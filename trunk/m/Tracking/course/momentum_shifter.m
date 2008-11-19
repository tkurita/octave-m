## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} momentum_shifter(@var{arg})
##
## @end deftypefn

##== History
## 2008-08-11
## * first implementation

function retval = momentum_shifter(dp)
  retval.dp = dp;
  retval.vector = [0; 0; dp; 0; 0; dp];
  retval.apply = @add_vector;
  retval.kind = "Momentum Shifter";
  retval.len = 0;
endfunction

%!test
%! momentum_shifter(x)
