## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} rf_with_harmonics(@var{t}, @var{params})
## Evaluate RF at time @var{t}.
## @strong{Inputs}
## @table @var
## @item params(1)
## a1 : Amplitude of fundamental wave
## @item params(2)
## a2ratio : Ratio of amplitude between fundamental and second harmonics
## @item params(3)
## f : Frequency of fundamental wave.
## @item params(4)
## phis : Synchronus phase.
## @item params(5)
## DC offset
## @end table
##
## @end deftypefn

function vt = rf_with_harmonics(t, args)
  vhat = abs(args(1)); # 基本波の電圧
  vratio = abs(args(2)); # 基本波と高調波の電圧比
  f = args(3); # 基本波の周波数
  phis= args(4); # 加速位相（２倍高調波の移相量）
  phi1 = args(5); # 基本波のオフセット位相
  c = args(6); # 全体のオフセット量
  
  v = vhat.*(sin(2*pi*f.*t + phi1) + vratio*sin(4*pi*f.*t + 2*phi1  - phis  + pi)) + c;
  vt = [t, v];
endfunction
