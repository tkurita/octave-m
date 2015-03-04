## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} func_name(@var{arg})
##
## @end deftypefn

##== History
## 2008-03-25
## initial implementaion

function result = is_Qmag(an_elem)
  result = isfield(an_elem, "kind");
  if (result)
    kinds = {"QF", "QD"};
    result = contain_str(kinds, an_elem.kind);
  end
  
endfunction