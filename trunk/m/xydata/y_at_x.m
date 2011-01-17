## -*- texinfo -*-
## @deftypefn {Function File} {@var{y1} =} y_at_x(@var{XY}, @var{x1})
##
## Find y value near @var{x1}.
## @var{xy} is two column matrix. 
##
## @end deftypefn

function y = y_at_x(xydata, x)
  if (nargin < 2)
    print_usage();
  endif
  y = interp1(xydata(:,1), xydata(:,2), x, "linear");
endfunction
