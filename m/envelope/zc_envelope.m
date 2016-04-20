## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} zc_envelope(@var{xy}, @var{diff_threshold})
## obtain min an max in on cycle crossing zero.
## @strong{Inputs}
## @table @var
## @item xy
## two column matrix
## @item diff_threshold
## when differences between indexes of positive values is greator than 
## @var{diff_threshold}, it is considered that @var{xy} crosses zero axes.
## @end table
##
## @strong{Outputs}
## When nargout is 1, a structure of which has following fields will be return.
## Otherwise multiple values will be returned.
## @table @code
## @item up_xy
## @item up_indexes
## @item down_xy
## @item down_indexes
## @item zc_indexes
## @end table
##
## @end deftypefn

function varargout = zc_envelope(xy, diff_threshold)
  if ! nargin
    print_usage();
  endif
  #diff_threshold = 3;
  t = xy(:,1);
  v = xy(:,2);
  # obtain zero-crossing indexes
  positive_indexes = find(v > 0);
  indexes_diff = diff(positive_indexes);
  ind_list = find(diff(positive_indexes) > diff_threshold);
  zc_indexes = positive_indexes(ind_list);

  # obtain minimum postion and its value.
  for n = 1:length(zc_indexes)-1
    yin = v(zc_indexes(n):zc_indexes(n+1));
    [min_values(n) ix] = min(yin);
    min_indexes(n) = zc_indexes(n)+ix-1;
    [max_values(n) ix] = max(yin);
    max_indexes(n) = zc_indexes(n)+ix-1;
  endfor
  
  if (nargout > 2)
    varargout = {[t(max_indexes)(:), max_values(:)], max_indexes,...
                 [t(min_indexes)(:), min_values(:)], min_indexes,...
                 zc_indexes};
  else
    varargout{end+1} = struct("up_xy", [t(max_indexes)(:), max_values(:)], ...
                       "up_indexes", max_indexes, ...
                       "down_xy", [t(min_indexes)(:), min_values(:)],...
                       "down_indexes", min_indexes, ...
                       "zc_indexes", min_indexes);
  endif
endfunction

%!test
%! func_name(x)
