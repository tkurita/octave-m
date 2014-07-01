## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} xy(@var{isf_data})
## Return 2d array of volt vs time.
##
## @end deftypefn

##== History
## 2014-07-01
## * support isf of TDS3000
## 2012-10-16
## * initial implementation.

function retval = xy(isf)
  y = isf.v;
  xinc = str2num(find_dict(isf.preambles, {"XIN", "XINCR"}));
  n = 0:length(y)-1;
  xzero = str2num(find_dict(isf.preambles, {"XZE", "XZERO"}));
  x = n*xinc + xzero;
  retval = [x(:), y(:)];
endfunction

function retval = find_dict(a_dict, keys)
  for k = keys
    if has(a_dict, k{:})
      retval = a_dict(k{:});
      return
    endif
  endfor
endfunction

%!test
%! func_name(x)
