# 
# tracing cic のシミュレーション
# CE パルスでリサンプルされた出力はシステムクロックで補間する。
#
# tcic(frev, fs, ce, ts)
# tcic(vin)
# 

function vout = apply_tcic(varargin)
  persistent frev fs cem ts tce ce_idx;
  if length(varargin) > 1
    frev = varargin{1};
    fs = varargin{2};
    cem = varargin{3};
#    tmax = varargin{4};
    ts = varargin{4}; # システムクロックの時間
    
    # CE pulse の計算
    cewave = sin(2*pi*frev*cem*ts);
    idx_p = find(cewave > 0);
    diff_idx_p = diff(idx_p);
    idx_diff = find(diff_idx_p > 1);
    ce_idx = idx_p(idx_diff+1);
    
    if mod(ts(end)-ts(1), 1/(frev*cem)) == 0
      ce_idx(end+1) = length(ts);
    endif
    return
  endif
  in_signal = varargin{1};
  
  # 積分
  sig_after_intgl = filter(1, [1, -1], in_signal);
  #size(sig_after_intgl)
  
  # CE シグナルで resampling
  #plot(t, sig_after_intgl, "-", t, in_signal, "-");
  sig_after_resample = sig_after_intgl(ce_idx);
  #tce = t(ceidx);
  #plot(t, sig_after_intgl, "-", tce, sig_after_resample, "*");
  
  # comb フィルター適用
  sig_after_comb = filter([1, zeros(1, cem-1), -1], 1, sig_after_resample);
  
  # システムクロックで補間
  vout = zeros(1, length(in_signal));
  preval = 0;
  preidx = 1;
  for n = 1:length(ce_idx)
    idx = ce_idx(n);
    vout(preidx:idx-1) = preval;
    preidx = idx;
    preval = sig_after_comb(n);
  endfor
  vout(preidx:end) = preval;
  #plot(sig_after_comb)
  #xlim([0,20]) # 1-13 の間、すなわち最初の 12 点は除去して振幅を計算する。
#  sig_after_comb(1:cem+1) = [];
#  amp = (max(sig_after_comb) + abs(min(sig_after_comb)))/2;
  # normalize
  vout = vout*frev/fs;
endfunction


if 1
  frev = 9.3762e+05; 
  fs = 150e6;
  cem = 12;
  tmax = 50/frev;
  ts = 0:1/fs:tmax;
  f = frev/2;
  vin = sin(2*pi*f*ts);
  vin_rev = sin(2*pi*frev*ts);
  apply_tcic(frev, fs, cem, ts);
#  df = 150e6/2^34*1000;
#  
#  df = 100; # Hz
#  f = 1e3:df:6e6;
  vout = apply_tcic(vin);
  vout_rev = apply_tcic(vin_rev);
  plot(ts, vout, sprintf("-;%f;", f) ...
     , ts, vout_rev, sprintf("-;%f;", frev))
endif

%!test
%! func_name(x)
