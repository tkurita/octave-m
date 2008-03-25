
##== History
## 2007-11-01
## * initial implementaion

function result = setup_fringing_sx(element_rec, sx)
#  result.strength = sx;
#  result.llamda = sx/2;
#  if (isfield(element_rec, "track_info") && strcmp(element_rec.track_info, "special"))
#    result.body = element_rec;
#  else
#    #element_rec
#    result.body = span_with_elements(element_rec);
#  endif
#  
#  result.apply = @through_fringing_sx;
#  result.track_info = "special";
  result = {thin_sx_element(sx, [element_rec.name, "_fringing_sx_entrance"])...
           , element_rec ...
           , thin_sx_element(sx, [element_rec.name, "_fringing_sx_exit"])};
endfunction
  