function a_tracker = tracker_at_position(an_elem, s)
  switch (an_elem.kind)
    case "ESD"
      an_elem.len = s;
      a_tracker.mat = ESCylindrical_mat(esd_struct);
      a_tracker.apply = @thorough_mat;
    case "DT"
      #a_tracker.mat = DTmat(s);
      an_elem.len = s;
      a_tracker.mat = mat_with_element(an_elem);
      a_tracker.apply = @thorough_mat;
    case "QF"
      an_elem.len = s;
      an_elem = QF(an_elem);
      a_tracker.mat = mat_with_element(an_elem);
      a_tracker.apply = @thorough_mat;
    case "QD"
      an_elem.len = s;
      a_tracker.mat = QD(an_elem);
      a_tracker.mat = mat_with_element(an_elem);
      a_tracker.apply = @thorough_mat;
    case "BM"
      an_elem.bmangle = s/an_elem.radius;
      a_tracker.mat = BMHmat(an_elem);
      a_tracker.apply = @thorough_mat;
    case "Kick"
    case "Shifter"
    otherwise
      error(sprintf("%s is unknown kind of element.", an_elem.kind);
  endswitch
endfunction