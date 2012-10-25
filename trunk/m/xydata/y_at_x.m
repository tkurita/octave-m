## -*- texinfo -*-
## @deftypefn {Function File} {@var{y1} =} y_at_x(@var{XY}, @var{x1})
##
## Evaluate y value at @var{x1} with linear interpetation.
## 
## @var{xy} is two column matrix. 
##
## @end deftypefn

##== History
## 2012-10-25
## * Improve document.

function y = y_at_x(xydata, x)
  if (nargin < 2)
    print_usage();
  endif
  y = interp1(xydata(:,1), xydata(:,2), x, "linear");
endfunction
