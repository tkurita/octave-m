## -*- texinfo -*-
## @deftypefn {Function File} {@var{h} =} circle(@var{center}, @var{radius}, [@var{properties}])
## @deftypefnx {Function File} {@var{retval} =} circle(@var{x}, @var{y}, @var{radius}, [@var{properties}])
##
## draw a circle specified with @{center} and @var{radius}
##
## properties : 
## @itemize
## @item edgecolor
## @item facecolor
## @item linetype
## @item linwidth
## @item and so on.
## @end itemize
## @end deftypefn

function h = circle(varargin)
  if nargin < 2
    print_usage();
    return;
  endif
  
  params = {};
  [reg, prop] = parseparams(varargin);
  switch length(reg)
    case 2
      c = reg{1};
      x = c(1);
      y = c(2);
      r = reg{2};
    otherwise
      x = reg{1};
      y = reg{2};
      r = reg{3};
  end
  
  d = r*2;
  px = x-r;
  py = y-r;
  h = rectangle("Position", [px py d d], "Curvature", [1,1], prop{:});
endfunction

%!test
%! func_name(x)
