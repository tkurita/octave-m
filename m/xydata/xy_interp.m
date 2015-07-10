## -*- texinfo -*-
## @deftypefn {Function File} {@var{xyi} =} xy_interp(@var{xy}, @var{xi}, @var{method})
## Obtain values at @var{xi} by interpolating @var{xy}.
##
## @strong{Inputs}
## @table @var
## @item xy
## @item xi
## @item method
## The default value is "linear"
## @end table
##
## @strong{Outputs}
## @table @var
## @item xyi
## [xi, yi]
## @end table
##
## @end deftypefn

function xyi = xy_interp(xy, xi, method = "linear")
  if ! nargin
    print_usage();
  endif
  vxi = xi(:);
  yi = interp1(xy(:, 1), xy(:, 2), vxi, method);
  xyi = [vxi, yi]; 
endfunction

%!test
%! func_name(x)
