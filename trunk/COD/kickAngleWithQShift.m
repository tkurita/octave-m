## * shiftVal -- [mm]
## * horv
function result = kickAngleWithQShift(element, shiftVal, horv)
  inVec = [-1*shiftVal/1000; 0; 0];
  outVec = element.mat.(horv) * inVec;
  result = outVec(2);
endfunction