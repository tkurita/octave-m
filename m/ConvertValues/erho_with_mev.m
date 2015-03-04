## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} echo_with_mev(@var{mev}, @var{amu}, @var{z})
## Return Electrostatic Rigidity [V * m]
##      p*v/(z*e)
## @end deftypefn

##== History
## 2008-08-11
## * first implementation

function retval = echo_with_mev(mev, amu, z)
  p = momentum_with_mev(mev, amu);
  v = velocity_with_mev(mev, amu);
  retval = p * v/z * 10^6;
endfunction

%!test
%! echo_with_mev(200, 1, 1)
