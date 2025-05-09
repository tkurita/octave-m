## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} loop_du_Vn(@var{config})
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

function varargout = loop_du_Vn(varargin)
  if !nargin
    print_usage();
    return;
  endif
  
  if nargin == 1
    config = varargin{1};
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
    gp = config.gp; # 1e-2: phase feedback gain
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

  lv = physical_constant("speed of light in vacuum"); # [m/s] light velocity
  g2 = 1/(1-(C*fr/lv)^2);
  eta = alp - (1/g2);
  wr = 2*pi*fr; # [rad/s] 周回周波数
  w_norm = linspace(1e-2, 1e2, 5000);
  w = w_norm * ws;
  s = i*w;
  if isnumeric(config.gr)
    gr = config.gr;
  elseif isstruct(config.gr)
    gr = (config.gr.K_P.*s + config.gr.K_I)./s;
  else
    gr = config.gr(s);
  endif
  
  D = G0*Nr*xp.*gr./(h*eta*wr); # D =  1.6761
  P = G0*Gp*gp;
  
  trf = (-G0.*e.^(-(Lc+Ld).*s).*s)./(s.^2 + P.*e.^(-Lc.*s).*s + ws.^2.*(1 + D.*e.^(-(2*Lc+Ld).*s)));
  m = abs(trf);
  p = angle(-1*trf); # du は Vn に対して極性が反転しているから
  if !nargout
    ax = plotyy(w_norm, 20*log10(m), w_norm, p*180/pi, @semilogx, @semilogx); grid on;...
    apply_to_axes("xlim", [1e-2,1e2]);
    ylim(ax(1), [-150, 0]);
    ylabel(ax(1), "\\Delta u / V_n [dB]");ylabel(ax(2), "phase [degree]");...
    xlabel("\\omega / \\omega_s");
  elseif nargout == 3
    varargout = {m, p, w};
  else
    config.mag = m;
    config.phase = p*180/pi;
    config.w = w;
    config.P = P;
    config.D = D;
    config.eta = eta;
    config.w_norm = w_norm;
    varargout = {config};
  endif

endfunction

%!test
%! loop_du_Vn(x)
