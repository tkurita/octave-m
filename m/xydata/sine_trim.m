## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} sine_trim(@var{xy})
## Trim head and tail a data to make the signal integral multiple of sine waves.
##
## @end deftypefn

## $Date::                           $
## $Rev$
## $Author$

##== History
## 2015-04-14
## * first implementation

function retval = sine_trim(xy)
  if ! nargin
    print_usage();
  endif
  
  diff_threshold = 5;
  t = xy(:,1);
  v = xy(:,2);
  if v(1) > 0
    chpoloar_idxes = find(v < 0);
    idx_list = find(diff(chpoloar_idxes) > diff_threshold);
    zc_head = chpoloar_idxes(idx_list(1))+1;
  else
    chpoloar_idxes = find(v > 0);
    zc_head = chpoloar_idxes(1);
  endif
  
  if v(end) > 0
    chpoloar_idxes = find(v < 0);
    zc_tail = chpoloar_idxes(end);
  else
    chpoloar_idxes = find(v < 0);
    idx_list = find(diff(chpoloar_idxes) > diff_threshold);
    zc_tail = chpoloar_idxes(idx_list(end));
  end
  retval = [t(zc_head:zc_tail)(:), v(zc_head:zc_tail)(:)];
endfunction

%!test
%! func_name(x)
