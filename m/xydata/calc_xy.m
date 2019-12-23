## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} calc_xy(@var{xy},"x+", @var{xshift}, "y+", @var{yshift}, "x*", @var{xfactor}, "y*", @var{yfactor}, "x.*", @var{xvec}, "y.*", @var{yvec})
##
## @end deftypefn

##== To Do
## * accept inline function or function handle as an argument.

function xy = calc_xy(xy, varargin)
  if (nargin < 3)
    print_usage();
  endif
  
  [px, py, mx, my, ebmx, ebmy] = get_properties(varargin, ...
                    {"x+", "y+", "x*", "y*", "x.*", "y.*"},...
                     {NaN, NaN, NaN, NaN, NaN, NaN});
  if isstruct(xy)
    if (!isnan(px))
      xy.x += px;
    endif
    if (!isnan(py))
      xy.y += py;
    endif
    if (!isnan(mx))
      xy.x *= mx;
    endif
    if (!isnan(my))
      xy.y *= my;
    endif
    if ! isnan(ebmx)
      xy.x .*= ebmx;
    endif
    if ! isnan(ebmy)
      xy.y .*= ebmy;
    endif
  else
    if (!isnan(px))
      xy(:,1) += px;
    endif
    if (!isnan(py))
      xy(:,2) += py;
    endif
    if (!isnan(mx))
      xy(:,1) *= mx;
    endif
    if (!isnan(my))
      xy(:,2) *= my;
    endif
    if ! isnan(ebmx)
      xy(:,1) .*= ebmx;
    endif
    if ! isnan(ebmy)
      xy(:,2) .*= ebmy;
    endif
  endif
endfunction

%!test
%! calc_xy(x)
