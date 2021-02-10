## -- retval = bode_PI_feedback(b, a, K_P, K_I, f)
##     PI制御器を含んだフィードバック系の bode 線図
##
##  * Inputs *
##    制御対象の伝達関数の係数。高い次数が先。
##    b : 分子
##    a : 分母
##   
##  * Outputs *
##    output of function
##    
##  * Exmaple *
##
##  See also: 

function bode_PI_feedback(b, a, K_P, K_I, f)
  if ! nargin
    print_usage();
    return;
  endif
  pkg load control;
  
  Gp = tf(b, a);
  Gc = tf([K_P, K_I], [1, 0]);
  
  bd1 = set_frequency(bode_data(Gc*Gp/(1 + Gc*Gp)), f);
  bd2 = set_frequency(bode_data(Gc), f);
  subplot(2,2,1);
  xyplot(gain_20dB(bd1)); ylabel("Magnitude [dB]")
  title("Closed Loop");
  subplot(2,2,2);
  xyplot(gain_20dB(bd2)); ylabel("Magnitude [dB]")
  title("PI Controller");
  subplot(2,2,3);
  xyplot(phase(bd1)); ylabel("Phase [deg]");
  subplot(2,2,4);
  xyplot(phase(bd2)); ylabel("Phase [deg]");
  apply_to_axes("xscale", "log");
  apply_to_axes("grid", "on");
  apply_to_axes("xlabel", "Frequency [Hz]");
endfunction

%!test
%! func_name(x)
if false
  wc = 2*pi*160;
  f = logspace(1, 4, 500);
  bode_PI_feedback(wc^2, [1, sqrt(2)*wc, wc^2], 0.1, 200, f);
endif

