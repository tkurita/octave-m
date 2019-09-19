## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} y_in_xrange(@var{xy}, @var{xmin}, @var{xmax})
## @deftypefnx {Function File} {@var{retval} =} y_in_xrange(@var{xy}, @var{xrange})
## Obtain y data between @var{xmin} and @var{xmax}.
##
## @strong{Inputs}
## @table @var 
## @item xrange
## a matrix of [@var{xmin}, @var{xmax}]
## @end table
##
## @end deftypefn

function retval = y_in_xrange(xy, varargin)
  if nargin <= 1
    print_usage();
  endif
  
  if isstruct(xy)
    x = xy.x;
    y = xy.y;
  else
    x = xy(:,1);
    y = xy(:,2);
  endif

  if is_function_handle(varargin{1})
    f = varargin{1};
    retval = y(f(x));
  else
    switch length(varargin)
      case 1
        xmin = varargin{1}(1);
        xmax = varargin{1}(2);
      otherwise
        xmin = varargin{1};
        xmax = varargin{2};
    endswitch
    retval = y((x >= xmin) & (x <= xmax));
  endif
endfunction

%!test
%! func_name(x)
