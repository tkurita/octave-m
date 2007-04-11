## usage : [codRecord_FB, codRecord_FT] = doubleFitCOD(codRecord_FB, codRecord_FT);
##
##= Parameters
## * codRecord (structure) 
##    .steererNames
##    .horv
##    .lattice
##    .brho
##    .tune
##    [.initialValues]
##= Results
##     .steererValues
##     .pError

function [codRecord_FB, codRecord_FT] = doubleFitCOD(codRecord_FB, codRecord_FT, shiftValue);
  global _fitCODInfo_FB;
  global _fitCODInfo_FT;
  global _shiftValue;
  _fitCODInfo_FB = codRecord_FB;
  _fitCODInfo_FT = codRecord_FT;
  _shiftValue = shiftValue;
  
  F = @doubleCODWithInterpolate;
  
  targetCOD = concatCOD(codRecord_FB.targetCOD, codRecord_FT.targetCOD, shiftValue);
  #stol=0.00000001; 
  stol=0.001; 
  niter=20;
  initialValues = zeros(4,1);
  global verbose;
  verbose=1;
  [f1, leasqrResults, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r21] = ...
  leasqr (targetCOD(:,1), targetCOD(:,2), initialValues, F, stol, niter);
  
#  leasqrResults
#  x = doubleCODWithInterpolate(targetCOD(:,1), leasqrResults)
#  plot(targetCOD(:,1), targetCOD(:,2), "@", targetCOD(:,1), x, "-")
  
  codRecord_FB.steererValues = [leasqrResults(1); leasqrResults(2); leasqrResults(4)];
  codRecord_FT.steererValues = [leasqrResults(1); leasqrResults(3); leasqrResults(4)];
  codRecord_FB.pError = 0;
  codRecord_FT.pError = 0;

endfunction