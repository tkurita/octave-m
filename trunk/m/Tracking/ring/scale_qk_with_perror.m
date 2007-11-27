#shareTerm /Users/tkurita/WorkSpace/シンクロトロン/2007.10 Tracking/extraction_tracking2/extraction_tracking2.m
function track_rec = scale_qk_with_perror(track_rec, p_error)
  all_elements = track_rec.lattice;
  for n = 1:length(all_elements)
    if (regexp(all_elements{n}.name, "^QF"))
      a_qf = all_elements{n};
      a_qf.k = a_qf.k/(1+p_error);
      a_qf = setup_element(a_qf, @QFmat, "h");
      a_qf = setup_element(a_qf, @QDmat, "v");
      all_elements{n} = a_qf;
    elseif (regexp(all_elements{n}.name, "^QD"))
      a_qd = all_elements{n};
      a_qd.k = a_qf.k/(1+p_error);
      a_qd = setup_element(a_qf, @QDmat, "h");
      a_qd = setup_element(a_qf, @QFmat, "v");      
      all_elememnts{n} = a_qd;
    elseif (isBendingMagnet(all_elements{n}))
      a_bm = all_elements{n};
      all_elements{n} = BM(a_bm, a_bm.name, "pError", p_error);
    endif
  endfor
  track_rec.lattice = all_elements;
endfunction

  