## -*- texinfo -*-
## @deftypefn {Function File} {@var{gp} =} gravity_point(@var{xy})
## evaluate a gravity point
## @strong{Inputs}
## @table @var
## @item xy
## column wise two dimensional matrix
## @end table
##
## @end deftypefn

##== History
## 2014-04-16
## * first implementation

function gp = gravity_point(xy)
  if ! nargin
    print_usage();
  endif
  x = xy(:,1);
  y = xy(:,2);
  gp = sum(x.*y)/sum(y);
endfunction

%!test
%! func_name(x)
