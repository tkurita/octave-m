## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} step_VM_Vx(@var{config})
## 
## evaluate step response of VM/Vx
##
## VM : output of BPM in [V]
## Vx : control value of ΔR
##
## @end deftypefn

function varargout = step_VM_Vx(config)
  pkg load control;
  if !nargin
    print_usage();
    return;
  endif
  
  if nargin == 1
    Nr = config.Nr;
    G0 = config.G0; # 2*pi*1e6/5 : [(rad/s)/V] VCO での電圧-周波数の変換係数 1MHz/5V
    Gp = config.Gp; # 5/pi : [V/rad] (ub-u0) を電圧に変換
      # u0 :RF pahse の変化量, ub : ビームの位相の変化量
      # 移相器±5V/±180度
      # gain設定 : 1
      # アンプ5 : 1 (0.1 から 1倍に変更された)
    C = config.C;
    R = C/(2*pi); # 平均半径
    Nr = config.Nr; # 100e-3/1e-3 [V/m] BPM の位置と電圧の変換係数 100mV/1mm
    xp = config.xp; # [m] BPM の位置での分散
    fr = config.fr;
    alp = config.alpha; # momentum compaction factor
    gr = config.gr; #
    gp = config.gp; # phase feedback gain
    h = config.h; # harmonics
    ws = config.ws; # [rad/sec] syncrotoron frequency
    Lc = 0; # [sec] cable delay
    Ld = 0; # [sec] degital delay in feedback circuit
    if isfield(config, "delay")
      Lc = config.delay;
    endif
    if isfield(config, "cable_delay")
      Lc = config.cable_delay;
    endif
    if isfield(config, "digital_delay")
      Ld = config.digital_delay;
    endif
  else
    print_usage();
    return;
  endif
  
  s = tf("s");
  if 0 == Lc
    lag_D = 1;
    lag_P = 1;
  else
    lag_D = pade_tf(s, 2*Lc, 1);
    lag_P = pade_tf(s, Lc, 1);
  endif
  
  lv = physical_constant("speed of light in vacuum"); # [m/s] light velocity

  g2 = 1/(1-(C*fr/lv)^2);
  eta = alp - (1/g2);
  wr = 2*pi*fr; # [rad/s] 周回周波数


  D0 = lag_D*G0*Nr*xp/(h*eta*wr); # gr 抜き
  P = lag_P*G0*Gp*gp;
  if (isstruct(config.gr))
    K_P = config.gr.K_P;
    K_I = config.gr.K_I;
    gr = (K_P*s+K_I)/s;
  else
    gr = config.gr;
  endif
  trf = (ws^2)*(D0*gr)/(s^2+P*s+ws^2*(1+D0*gr)); # inverted

  t = linspace(0, 0.003, 300);
  if nargout
    [y, t] = step(trf, t);
    varargout = {[t, y]};
  else
    step(trf, t);
  endif
endfunction


%!test
%! loop_dR_Vx(x)
