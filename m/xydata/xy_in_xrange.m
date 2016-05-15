## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} xy_in_xrange(@var{xy}, @var{xmin}, @var{xmax})
## @deftypefnx {Function File} {@var{retval} =} xy_in_xrange(@var{xy}, @var{xrange})
## Obtain xy data between @var{xmin} and @var{xmax}.
##
## @strong{Inputs}
## @table @var 
## @item xrange
## a matrix of [@var{xmin}, @var{xmax}]
## @end table
##
## @end deftypefn

##== History
## 2014-12-23
## * first implementation

function retval = xy_in_xrange(xy, varargin)
  if nargin <= 1
    print_usage();
  endif
  
  if is_function_handle(varargin{1})
    f = varargin{1};
    retval = xy(f(xy(:,1)), :);
  else
    switch length(varargin)
      case 1
        xmin = varargin{1}(1);
        xmax = varargin{1}(2);
      otherwise
        xmin = varargin{1};
        xmax = varargin{2};
    endswitch

    x = xy(:,1);
    retval = xy((x >= xmin) & (x <= xmax), :);
  endif
endfunction

%!test
%! func_name(x)
