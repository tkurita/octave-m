## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} func_name(@var{arg})
##
## @end deftypefn

##== History
## 2008-03-17
## * first implementaion

function result = element_info_at(element_rec, pos_in_elem)
  result.twpar = element_rec.([pos_in_elem, "Twpar"]);
  result.phase = element_rec.([pos_in_elem, "Phase"]);
  result.position = element_rec.([pos_in_elem, "Position"]);
endfunction