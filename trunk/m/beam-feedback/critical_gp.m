## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} critical_gp(@var{config})
## description
## @strong{Inputs}
## @table @var
## @item arg1
## description of @var{arg}
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## description of @var{retval}
## @end table
##
## @end deftypefn

##== History
##

function gp = critical_gp(config)
  if !nargin
    print_usage();
    return;
  endif
  
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
  gr = config.gr; # -0.03
  h = config.h; # harmonics
  ws = config.ws; # [rad/sec] syncrotoron frequency

  lv = physical_constant("SPEED_OF_LIGHT_IN_VACUUM"); # [m/s] light velocity

  g2 = 1/(1-(C*fr/lv)^2);
  eta = alp - (1/g2);
  wr = 2*pi*fr; # [rad/s] 周回周波数
  D = G0*Nr*xp*gr/(h*eta*wr); # D =  1.6761
  gp = 2*ws*sqrt(1+D)/(G0*Gp);

endfunction

%!test
%! critical_gp(x)
