## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} zc_envelop(@var{arg})
## obtain min an mas in on cycle crossing zero.
## @strong{Inputs}
## @table @var
## @item arg1
## description of @var{arg}
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## description of @var{retval}
## @end table
##
## @end deftypefn

##== History
##

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
  
  varargout = {[t(max_indexes)(:), max_values(:)], max_indexes,...
               [t(min_indexes)(:), min_values(:)], min_indexes,...
               zc_indexes};
endfunction

%!test
%! func_name(x)
