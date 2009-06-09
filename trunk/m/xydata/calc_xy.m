## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} calc_xy(@var{xy},"x+", @var{xshift}, "y+", @var{yshift}, "x*", @var{xfactor}, "y*", @var{yfactor})
##
## @end deftypefn

##== History
## 2009-05-20
## * First implementaion. Will replace factoryX/Y shift_xy

function xy = calc_xy(xy, varargin)
  if (nargin < 4)
    print_usage();
  endif
  
  [px, py, mx, my] = get_properties(varargin, ...
                    {"x+", "y+", "x*", "y*"}, {NaN, NaN, NaN, NaN});
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
endfunction

%!test
%! calc_xy(x)
