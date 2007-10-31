## usage : codRecord = fitCOD(codRecord [,fixedKikerInfo]);
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
## 
## 2006.09.08
## * ficked kicker 機能を復活
## * 第２返り値として fixed kikcer の codRecord をかえす。
##
## 2006.07.17
## * steererValues ではなく、kickAngles を parameter として使うようにする。
## * fixedKicker 機能が壊れている

function [codRecord, fixedKickerRec] = fitCOD(codRecord, varargin);
  global _fitCODInfo;
  global _existsFixedKicker;
  global _fixedKickerInfo;
  _fitCODInfo = codRecord;
  
  ##== setup fixed kickers
  _existsFixedKicker = (length(varargin) > 0);
  if (_existsFixedKicker)
    _fixedKickerInfo = setupFixedKickerInfo(varargin{1}, codRecord);
    fixedKickerRec = _fixedKickerInfo;
  endif
  
  if (isfield(codRecord, "initialValues"))
    initialValues = codRecord.initialValues;
  else
    initialValues = zeros(length(codRecord.steererNames),1);
    #initialValues = zeros(length(codRecord.steererNames));
  endif
  
  switch codRecord.horv
    case "h"
      ignorePerror = false;
      if (isfield(codRecord, "ignorePerror"))
        ignorePerror = codRecord.ignorePerror;
      endif
      
      if (ignorePerror)
        clear codWithInterpolate;
        F = @codWithInterpolate;
      else
        clear codWithInterpWithPerror;
        F = @codWithInterpWithPerror;
        initialValues = [initialValues; 0];        
      endif
    case "v"
      clear codWithInterpolate;
      F = @codWithInterpolate;
    otherwise
      error("codRecord.horv must be \"h\" or \"v\"");
  endswitch
  
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
  
  switch codRecord.horv
    case "h"
      if (ignorePerror)
        #codRecord.steererValues = leasqrResults;
        codRecord.kickAngles = leasqrResults;
        codRecord.pError = 0;
      else
        #codRecord.steererValues = leasqrResults(1:length(leasqrResults)-1);
        codRecord.kickAngles = leasqrResults(1:end-1);
        codRecord.pError = leasqrResults(end);
      endif
    case "v"
      #codRecord.steererValues = leasqrResults;
      codRecord.kickAngles = leasqrResults;
      codRecord.pError = 0;
  endswitch
  
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

function codRecord_fixedKicker = setupFixedKickerInfo(fixedKickerInfo, codRecord)
  try
    isKickAngle = fixedKickerInfo.isKickAngle;
  catch
    isKickAngle = false;
  end_try_catch
  
  codRecord_fixedKicker = setfields(codRecord\
    , "steererNames", fixedKickerInfo.names, "pError", 0);  
  
  if (isKickAngle)
    codRecord_fixedKicker.kickAngles = fixedKickerInfo.values;
  else
    kickAngles = [];
    for i = 1:length(fixedKickerInfo.names);
      currentElement = getElementWithName(codRecord.lattice, fixedKickerInfo.names{i});
      kickAngles(i) = calcSteerAngle(currentElement, fixedKickerInfo.values(i), codRecord.brho);
    endfor
    codRecord_fixedKicker.kickAngles = kickAngles;
  endif
  
  if (isfield(fixedKickerInfo, "range"))
    codRecord_fixedKicker.range = fixedKickerInfo.range;
  endif
  
  codRecord_fixedKicker.COD = calcCODWithPerror(codRecord_fixedKicker);
endfunction
