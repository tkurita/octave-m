
##== History
## 2007-11-01
## * initial implementaion

function retval = setup_fringing_sx(element_rec, bm_sx)
  retval.strength = bm_sx;
  retval.llamda = bm_sx/2;
  if (isfield(element_rec, "track_info") && strcmp(element_rec.track_info, "special"))
    retval.body = element_rec;
  else
    #element_rec
    retval.body = span_with_elements(element_rec);
  endif
  
  retval.apply = @through_fringing_sx;
  retval.track_info = "special";
endfunction
  