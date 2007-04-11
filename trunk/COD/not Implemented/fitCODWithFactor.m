## usage : codRecord = fitCODWithFactor(codRecord [,fixedKikerInfo]);
##
##= Parameters
## * codRecord (structure) 
##    .steererNames
##    .horv
##    .lattice
##    .brho
##    .tune
##    [.initialValues]
##    [.ignorePerror] -- 運動量誤差を fitting parameter に含めるかどうか。省略時 false
##= Results
## following fields are appended.
##     .steererValues
##     .pError

##= History
## 2006.07.17
##  steererValues ではなく、kickAngles を parameter として使うようにする。
##  fixedKicker 機能が壊れている

function codRecord = fitCODWithFactor(codRecord, varargin);
  global _fitCODInfo;
  global _existsFixedKicker;
  global _fixedKickerInfo;
  _fitCODInfo = codRecord;
  _fitCODInfo = rmfield("kickAngles");
  
  _existsFixedKicker = (length(varargin) > 0);
  if (_existsFixedKicker)
    _fixedKickerInfo = varargin{1};
  endif
  
  initialValues = [1;0];
  
  if (isfield(codRecord, "ignorePerror"))
    ignorePerror = codRecord.ignorePerror;
  else
    ignorePerror = false;
  endif
  
  switch codRecord.horv
    case "h"
      _fitCODInfo.ignorePerror = ignorePerror;
    case "v"
      ignorePerror = true;
      _fitCODInfo.ignorePerror = true;
    otherwise
      error("codRecord.horv must be \"h\" or \"v\"");
  endswitch
  F = @codByFactorAndPerror
  stol=0.00000001; 
  niter=500;
  #  stol=0.0001; 
  #  niter=10;
  
  global verbose;
  verbose=1;
  [f1, leasqrResults, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r21] = ...
  leasqr (codRecord.targetCOD(:,1), codRecord.targetCOD(:,2), initialValues, F, stol, niter);
  #   [f1, leasqrResults, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r21] = ...
  #       leasqr (targetCOD_FB(:,1), targetCOD_FB(:,2), initialValues, F, stol, niter);
  
  codRecord.steererValues = leasqrResults(1:end-1);
  if (!ignorePerror)
    codRecord.pError = leasqrResults(end);
  endif
  
  
  ## convert kick angle to steerer value
  allElements = codRecord.lattice;
  steererValues = [];
  for n = 1:length(allElements)
    currentElement = allElements{n};
    elementName = currentElement.name;
    for m = 1:length(codRecord.steererNames)
      if (strcmp(elementName, codRecord.steererNames{m}))
        steererValues = [steererValues; calcKickerValue(currentElement, codRecord.kickAngles(m), codRecord.brho)];
      endif
    endfor
  endfor
  codRecord.steererValues = steererValues;
endfunction