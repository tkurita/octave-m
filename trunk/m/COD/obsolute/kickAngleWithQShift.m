## * shiftVal -- [mm]
## * horv
function result = kickAngleWithQShift(element, shiftVal, horv)
  warning("kickAngleWithQShift is deprecated. Use kick_with_QM_shift.");
  inVec = [-1*shiftVal/1000; 0; 0];
  outVec = element.mat.(horv) * inVec;
  result = outVec(2);
endfunction