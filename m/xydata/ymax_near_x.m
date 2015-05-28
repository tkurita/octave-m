## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} ymax_near_x(@var{xy}, @var{x}, @var{span})
## find maximum y in a range from @var{x}-@var{span}/2 to @var{x}+@var{span}/2
##
## @strong{Outputs}
## @table @var
## @item retval
## a two column matrix [x_for_ymax, ymax].
## @end table
##
## @end deftypefn

function [retval, idx] = ymax_near_x(xy, x, span)
  if ! nargin
    print_usage();
  endif
  x = reshape(x, 1, prod(size(x))); # raw-wise
  xlist = xy(:,1);
  spanmat = bsxfun(@gt, xlist, x-span/2) & bsxfun(@le, xlist, x+span/2);
  ymulti = repmat(xy(:,2), 1, length(x));
  ymulti(!spanmat) = NA;
  [ymax, idx] = max(ymulti);
  x_at_max = xlist(idx);
  retval = [x_at_max(:), ymax(:)];
endfunction

%!test
%! func_name(x)
