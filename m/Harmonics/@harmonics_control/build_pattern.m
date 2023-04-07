## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} harmonics_controlv_pattern(@var{blpattern}, @var{rfvpattern}, @var{timmings}, @var{A2PM2file}, @var{pstablefile}, options, ...)
##
## Make an object to evaluate control voltage pattern for the Harmonics Controller.
##
## @strong{Inputs}
## @table @var
## @item arg1
## description of @var{arg}
## @end table
##
## @var{timmings} is a structure following fields.
## @table @code
## @item tstep
## in millisecond. 1 ms for Agilent F.G.
## @item end_pattern
## 800 [ms] 高調波パターンデータ終了
## @item start_capture
## 25 [ms] 捕獲開始タイミング
## @item stop_amp
## 290 [ms] 高調波振幅停止
## @item amp_zero
## 310 [ms] 高調波振幅をゼロ
## @item stop_phase
## 310 [ms] 高調波位相停止。 amp_zero 異常であるべき
## @end table 
##
## @strong{Outputs}
## @table @var
## @item retval
## description of @var{retval}
## @end table
##
## @end deftypefn

function self = build_pattern(self, blpattern ...
                              , rfvpattern, timmings ,varargin)
  if ! nargin
    print_usage();
    return;
  endif
  
  opts = get_properties(varargin, ...
                {"bmangle", pi/4;
                "circumference", 33.201;
                "freq_base", NA;
                "freq_top", NA;
                "particle", "proton";
                "harmonics", 1});
                
  tstep = timmings.tstep;
  # 加速電圧が発生しはじめる最初の時系列データのindex
  start_cap_idx = timmings.start_capture/tstep +1; 
  stop_amp_idx = timmings.stop_amp/tstep +1;
  amp_zero_idx = timmings.amp_zero/tstep +1;
  stop_phase_idx = timmings.stop_phase/tstep +1;
  
  ##== 定数
  C = opts.circumference; #[m] 周長
  lv = physical_constant("speed of light in vacuum");
  proton_ev = physical_constant("proton mass energy equivalent in mev")*1e6;
  h = opts.harmonics;
  
  ##== 偏向電磁石パターン dBL/dt の構築
  if iscell(blpattern)
    [bm_pattern, t_in_ms] = bvalues_for_period(blpattern, tstep ...
                                    , 0, timmings.end_pattern);
    dBLdt_pattern = dbdt_at_time(blpattern, t_in_ms)*1000;
  else
    t_in_ms = 0:tstep:timmings.end_pattern;
    bm_pattern = interp1(blpattern(:,1), blpattern(:,2), t_in_ms, "linear");
    dBLdt_pattern = gradient(blpattern(:,2), blpattern(:,1)/1000);
    dBLdt_pattern = interp1(blpattern(:,1), dBLdt_pattern, t_in_ms, "linear");
  endif
  secList = t_in_ms/1000;

  ##== 加速電圧パターンの構築
  for n = 2:length(rfvpattern)
    rfvpattern(1,n) += rfvpattern(1, n-1);
  end
  rfv_pattern=interp1(rfvpattern(1,:), rfvpattern(2,:), t_in_ms, "linear"); #加速RF電圧

  if isna(opts.freq_base)
    ##== 加速RF周波数の計算--偏向電磁石の磁場から
    velocityList = velocity_with_brho(bm_pattern/(pi/4), "carbon")';
  elseif isna(opts.freq_top)
    ##== 加速RF周波数の計算--偏向電磁石の磁場変化量から
    # maximum error about 5kHz when time step is 1msec.
    preVelocity = C*opts.freq_base/h;
    velocityList = [];
    dvdtList = [];
    for dBLdt = dBLdt_pattern'
      v = preVelocity;
      b = v/lv;
      dbrho_dt = dBLdt/(pi/4);
      g =  (1 - b^2)^(-1/2);
      dvdt = (lv^2 * dbrho_dt)/(proton_ev * (g + b^2 * (1- b^2 )^(-3/2) ));
      dvdtList = [dvdtList; dvdt];
      preVelocity = preVelocity + dvdt*(tStep/1000);
      velocityList(end+1) = preVelocity;
    endfor
  else
    bbase = bm_pattern(1)/opts.bmangle;
    btop = bm_pattern(end)/opts.bmangle;
    b_fbase = brho_with_frev(opts.freq_base/h/1e6, C, opts.particle);
    b_ftop = brho_with_frev(opts.freq_top/h/1e6, C, opts.particle);
    A = (b_fbase - b_ftop)/(bbase-btop);
    B = b_fbase- A*bbase;
    brholist = A*(bm_pattern/(pi/4))+B;
    velocityList = velocity_with_brho(brholist, opts.particle)';
  endif
  rf_in_Hz = h*velocityList./C;
  
  ##= 加速位相の計算
  sinphi = (C.*dBLdt_pattern(:)./(pi/4))./rfv_pattern(:);
  stacked_plot(2,1);
  plot(dBLdt_pattern(:)./(pi/4), "-;dBrho;");
  stacked_plot(2,2);
  plot(rfv_pattern, "-;RF Voltage;");
  save_plot("syncphase-rfv.pdf");
  
  # 電圧が発生されるまでを強制的に 0 にする。
  sinphi(1:start_cap_idx) = zeros(start_cap_idx, 1);
  phis=asin(sinphi);
  
  ##=２倍高調波制御装置の特性
  phase_base_v = forward_interp(self._properties.ci_phase_base...
                              , rf_in_Hz);
  if isfield(self._properties, "pstable")
    phase_ctrlv = phase_base_v;
    pstable = self._properties.pstable;
    for n = 1:stop_phase_idx
      rf_in_Hz(n)
      pscurve = pstable.curve_for_Hz(rf_in_Hz(n));
      bias_rad = rad_for_v(pscurve, phase_base_v(n))
      phase_ctrlv(n) = v_for_rad(pscurve, bias_rad + phis(n))
    endfor
  else
    pscurve = self._properties.pscurve;
    bias_rad = rad_for_v(pscurve, phase_base_v);
    # phase shifter の校正曲線を使って、rad から制御電圧への逆変換が
    # はいくらかずれる。多項式近似をしているためと思われる。
    # 変化分を計算し、位相0を与える電圧に足し合わせる。
    dv = v_for_rad(pscurve, bias_rad(:) + phis(:)) ...
          - v_for_rad(pscurve, bias_rad(:));
    phase_ctrlv = phase_base_v(:) + dv;
  endif
  ##== stop_phase 以降を一定にする。
  phase_ctrlv(stop_phase_idx:length(phase_ctrlv)) = phase_ctrlv(stop_phase_idx);

  ##= 2倍高調波の振幅の制御電圧を計算
  amp_ctrlv = forward_interp(self._properties.ci_amp, rf_in_Hz);
  
  ##== 立ち上がりを0Vから直線で立ち上げる。
  starting_line_y = [0, amp_ctrlv(start_cap_idx)];
  starting_line_x = [0, t_in_ms(start_cap_idx)];
  
  starting_data = interp1(starting_line_x, starting_line_y ...
                          , t_in_ms(1:start_cap_idx));
  amp_ctrlv(1:start_cap_idx) = starting_data;
  
  ##== 立ち下がり部分を設定
  ending_line_y = [amp_ctrlv(stop_amp_idx), 0];
  ending_line_x = [t_in_ms(stop_amp_idx), timmings.amp_zero];
  
  ending_data = interp1(ending_line_x, ending_line_y ...
                        ,t_in_ms(stop_amp_idx:amp_zero_idx));
  amp_ctrlv(stop_amp_idx:amp_zero_idx) = ending_data;
  amp_ctrlv(amp_zero_idx:length(amp_ctrlv)) = 0;
  
  self._properties = append_fields(self._properties ...
            , phase_ctrlv, amp_ctrlv, rf_in_Hz, phis, sinphi, t_in_ms ...
            , bm_pattern,  rfv_pattern, dBLdt_pattern);
endfunction


