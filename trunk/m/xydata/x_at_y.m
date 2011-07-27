## -*- texinfo -*-
## @deftypefn {Function File} {@var{x1} =} x_at_y(@var{XY}, @var{y1})
##
## Find x value near @var{y1}.
## @var{xy} is two column matrix. 
##
## @end deftypefn

##== History
## 2011-07-27
## * first implementation

function x = x_at_y(xydata, y)
  if (nargin < 2)
    print_usage();
  endif
  x = interp1(xydata(:,2), xydata(:,1), y, "linear");
endfunction
