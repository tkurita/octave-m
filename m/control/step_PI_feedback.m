## -- retval = bode_PI_feedback(b, a, K_P, K_I, [t])
##     PI制御器を含んだフィードバック系のステップ応答
##
##  * Inputs *
##    制御対象の伝達関数の係数。高い次数が先。
##    b : 分子
##    a : 分母
##    
##    PI 制御器のゲイン
##    K_P : 比例ゲイン
##    K_I : 積分ゲイン
##
##  * Outputs *
##    output of function
##    
##  * Exmaple *
##
##  See also: 

function retval = step_PI_feedback(b, a, K_P, K_I, varargin)
  if ! nargin
    print_usage();
    return;
  endif
  pkg load control;
  
  Gp = tf(b, a);
  Gc = tf([K_P, K_I], [1, 0]);
  step(Gc*Gp/(1 + Gc*Gp), varargin{:})
endfunction

%!test
%! func_name(x)
if false
  wc = 2*pi*160;
  f = logspace(1, 4, 500);
  step_PI_feedback(wc^2, [1, sqrt(2)*wc, wc^2], 0.1, 200, f);
endif

