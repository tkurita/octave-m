function a_tracker = tracker_at_position(an_elem, s)
  switch (an_elem.kind)
    case "ESD"
      an_elem.angle = s/an_elem.radius;
      an_elem = ESD(an_elem);
      a_tracker.mat = mat_with_element(an_elem);
      a_tracker.apply = @through_mat;
    case "DT"
      an_elem.len = s;
      an_elem = DT(an_elem);
      a_tracker.mat = mat_with_element(an_elem);
      a_tracker.apply = @through_mat;
    case "QF"
      an_elem.len = s;
      an_elem = QF(an_elem);
      a_tracker.mat = mat_with_element(an_elem);
      a_tracker.apply = @through_mat;
    case "QD"
      an_elem.len = s;
      an_elem = QD(an_elem);
      a_tracker.mat = mat_with_element(an_elem);
      a_tracker.apply = @through_mat;
    case "BM"
      an_elem.bmangle = s/an_elem.radius;
      an_elem = BM(an_elem);
      a_tracker.mat = mat_with_element(an_elem);
      a_tracker.apply = @through_mat;
    case "Apperture Lens"
      a_tracker.mat = mat_with_element(an_elem);
      a_tracker.apply = @through_mat;
    case "Acceleration Tube"
      an_elem.len = s;
      an_elem = rmfield(an_elem, "ratio");
      an_elem = AT(an_elem);
      a_tracker.mat = mat_with_element(an_elem);
      a_tracker.apply = @through_mat;
    case "Kicker"
      a_tracker = an_elem;
    case "Shifter"
      a_tracker = an_elem;
    case "Rotator"
      a_tracker = an_elem;
    case "Unshifter"
      a_tracker = an_elem;
    case "Momentum Shifter"
      a_tracker = an_elem;
    otherwise
      error(sprintf("%s is unknown kind of element.", an_elem.kind));
  endswitch
endfunction