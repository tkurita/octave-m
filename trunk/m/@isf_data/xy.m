## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} xy(@var{isf_data})
## Return 2d array of volt vs time.
##
## @end deftypefn

##== History
## 2012-10-16
## * initial implementation.


function retval = xy(isf)
  y = isf.v;
  xinc = str2num(isf.preambles("XIN"));
  n = 0:length(y)-1;
  xzero = str2num(isf.preambles("XZE"));
  x = n*xinc + xzero;
  retval = [x(:), y(:)];
endfunction

%!test
%! func_name(x)
