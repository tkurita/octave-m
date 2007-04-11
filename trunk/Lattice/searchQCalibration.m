## function result = searchQValueAndVEdge(tune1, tune2,  QFDRatio, delQFRatio, delQDRatio)
## 
##= arguments
## * tunes -- [nx, ny]
## * qSettings 
## (tune1, tune2, delQFRatio, delQDRatio)
## (tune1, tune2,  QFDRatio, delQFRatio, delQDRatio)
function result = searchQCalibration(tunes, qSettings)
  
  global _tunes;
  global _qSettings;
  global _brho;
  _tunes = tunes;
  _qSettings = qSettings;
  _brho = BrhoForMeV(10, "proton");
  qlength = 0.21; 
  initialQCalValue = [1/qlength; 0; 1/qlength; 0];
  initialVedge = 0;
  initialValues = [initialQCalValue; initialVedge];
  targetX = (1:(2*size(tunes)(1)))';
  targetY = tunes(:);
  F = @calcMultiTunes;
  
  stol=0.0001; 
  niter=10;
  global verbose;
  verbose=1;
  [f1, leasqrResults, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r21] = ...
  leasqr (targetX, targetY, initialValues, F, stol, niter);
  
  vedge = leasqrResults(end);
  qfkLengthFactor = 1/leasqrResults(1);
  qfkOffset = leasqrResults(2);
  qdkLengthFactor = 1/leasqrResults(3);
  qdkOffset = leasqrResults(4);
  result = tar(qfkLengthFactor, qfkOffset, qdkLengthFactor, qdkOffset, vedge);
endfunction

function result = calcMultiTunes(dummy, qCalValues)
  #qCalValues
  global _tunes;
  global _qSettings;
  global _brho;
  vedge = abs(qCalValues(end));
  offset = repmat([qCalValues(2), qCalValues(4)], size(_tunes)(1), 1);
  factor = repmat([qCalValues(1), qCalValues(3)], size(_tunes)(1), 1);
  qValMat = (_qSettings.*factor + offset)/_brho;
  for n = 1:size(qValMat)(1)
    qfVal = qValMat(n,1);
    qdVal = qValMat(n,2);
    [lattice, tuneDict] = calcLatticeSimple(qfVal, qdVal, vedge);
    result(n,1) = tuneDict.h;
    result(n,2) = tuneDict.v;
  endfor
  result = result(:);
  #result
endfunction
