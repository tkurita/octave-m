## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} half_element(@var{arg})
##
## @end deftypefn

##== History
## 2008-03-27
## * 後半の matrix を求める計算を間違えていたのを修正
##
## 2008-03-26
## * first implementation

function result = half_element(an_elem, first_half)
  if (first_half)
    result.mat = an_elem.mat_half;
  else
    for ([val, key] = an_elem.mat_half)
      result.mat.(key) = an_elem.mat.(key)*inv(val);
    endfor
    #result.mat = an_elem.mat_half*inv(an_elem.mat_half);
  endif

endfunction