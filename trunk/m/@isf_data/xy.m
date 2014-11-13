## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} xy(@var{isf_data})
## Return 2d array of volt vs time.
##
## @end deftypefn

##== History
## 2014-11-13
## * use isf_data.t
## 2014-07-01
## * support isf of TDS3000
## 2012-10-16
## * initial implementation.

function retval = xy(isf)
  retval = [isf.t(:), isf.v(:)];
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
