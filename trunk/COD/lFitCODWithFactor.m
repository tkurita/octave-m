## usage : codRecord = lFitCODWithFactor(codRecord);
##
## fit COD with factor and momemtum error.
##
##= Parameters
## * codRecord (structure) 
##    .steererNames
##    .horv
##    .lattice
##    .tune
##    .kickAngles
##
##= Results
## following fields are appended.
##    .pError
##    .kickFactor

##= History
## 2006.07.17
##  fitCOD(using non-linear least square method) と同じ結果が得られることを確認
##

function codRecord = lFitCODWithFactor(codRecord, varargin);
  if (isfield(codRecord, "kickFactor"))
    codRecord = rmfield(codRecord, "kickFactor");
  endif

  codMatStruct = buildCODMatrix(codRecord);
  codList = applyKickerAngle(codMatStruct, codRecord);
 
  switch (codRecord.horv)
    case "h"
      X = [codList, codMatStruct.dispersion];
    case "v"
      X = codList;
    otherwise
      error("codRecord.horv must be \"h\" or \"v\"");
  endswitch
  
  refCODList = codMatStruct.refCOD/1000; # convert unit from [mm] to [m]
  kickFactorResult = X \ refCODList;
  
  switch (codRecord.horv)
    case "h"
      codRecord.kickFactor = kickFactorResult(1);
      codRecord.pError = kickFactorResult(end);
    case "v"
      codRecord.kickFactor = kickFactorResult;
      codRecord.pError = 0;
    otherwise
      error("codRecord.horv must be \"h\" or \"v\"");
  endswitch
  
endfunction