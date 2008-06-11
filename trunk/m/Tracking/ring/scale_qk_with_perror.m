##== History
## 2008-06-02
## * QD の設定変更が行われていなかった
##

function track_rec = scale_qk_with_perror(track_rec, p_error)
  all_elements = track_rec.lattice;
  for n = 1:length(all_elements)
    elem = all_elements{n};
    if (regexp(elem.name, "^QF"))
      elem.k = elem.k/(1+p_error);
      elem = setup_element(elem, @QFmat, "h");
      elem = setup_element(elem, @QDmat, "v");
      all_elements{n} = elem;
    elseif (regexp(elem.name, "^QD"))
      elem.k = elem.k/(1+p_error);
      elem = setup_element(elem, @QDmat, "h");
      elem = setup_element(elem, @QFmat, "v");      
      all_elements{n} = elem;
    elseif (is_BM(elem))
      all_elements{n} = BM(elem, elem.name, "pError", p_error);
    endif
  endfor
  track_rec.lattice = all_elements;
endfunction

  