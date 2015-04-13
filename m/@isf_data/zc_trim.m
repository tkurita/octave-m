## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} zc_trim(@var{arg})
## Trim head and tail a data to make the signal integral multiple of sine waves.
##
## @end deftypefn

## $Date::                           $
## $Rev$
## $Author$

##== History
## 2015-04-09
## * first implementation

function retval = zc_trim(isf)
  diff_threshold = 5;
  v = isf.v;
  t = subsref(isf, struct("type", ".", "subs", "t"));
  xzero = str2num(isf.preambles.XZE);
  xinc = subsref(isf, struct("type", ".", "subs", "ts"));
  # trim head
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
