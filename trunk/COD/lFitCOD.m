## usage : codRecord = lFitCOD(codRecord [,fixedKikerInfo]);
##
## using linear least square method
##
##= Parameters
## * codRecord (structure) 
##    .steererNames
##    .horv
##    .lattice
##    .brho
##    .tune
##    [.ignorePerror] -- 運動量誤差を fitting parameter に含めるかどうか。省略時 false
##
##= Results
## following fields are appended.
##     .kickAngles
##     .steererValues
##     .pError

##= History
## 2006.07.17
##  fitCOD(using non-linear least square method) と同じ結果が得られることを確認
##

function codRecord = lFitCOD(codRecord, varargin);
  steererNames = codRecord.steererNames;
  
  allElements = codRecord.lattice;
  brho = codRecord.brho;
  tune = codRecord.tune;
  horv = codRecord.horv;
  
  ##== pick up steerer parameters
  stBetaList = []; # beta function at center position of steerers
  stPhaseList = []; # phase advance at center position of steerers
  stNameList = {};
  for m = 1:length(allElements)
    currentElement = allElements{m};
    for n = 1 : length(steererNames)
      if (strcmp(allElements{m}.name, steererNames{n}))
        stPhaseList = [stPhaseList, currentElement.centerPhase.(horv)];
        stBetaList = [stBetaList, currentElement.centerBeta.(horv)];
        stNameList = {stNameList{:}, steererNames{n}};
        kickers.(steererNames{n}) = allElements{m};
        break;
      endif
    endfor
  endfor
  
  ##== pick up reference points parameters
  refBetaList = []; # beta function at center position of reference elements
  refPhaseList = []; # phase advance at center position of reference elements
  refDispersionList = []; # dispersion at center positon of reference elements
  refCODList = [];
  refNameList = {};
  for n = 1:length(allElements)
    currentElement = allElements{n};
    elementName = currentElement.name;
    if (isfield(codRecord.codAtBPM, elementName))
      refPhaseList = [refPhaseList, currentElement.centerPhase.(horv)];
      refBetaList = [refBetaList, currentElement.centerBeta.(horv)];
      refDispersionList = [refDispersionList, currentElement.centerDispersion];
      refCODList = [refCODList; codRecord.codAtBPM.(elementName)];
      refNameList = {refNameList{:}, elementName};
    endif
  endfor
  nst = length(stBetaList);
  nref = length(refBetaList);
  X = repmat(sqrt(refBetaList'),1,nst).* repmat(sqrt(stBetaList), nref, 1);
  cosX = cos(pi*tune.(horv) - abs(repmat(refPhaseList',1,nst) - repmat(stPhaseList,nref,1)));
  
  switch (codRecord.horv)
    case "h"
      X = [X.*cosX/(2*sin(pi*tune.(horv))), refDispersionList'];
    case "v"
      X = X.*cosX/(2*sin(pi*tune.(horv)));
    otherwise
      error("codRecord.horv must be \"h\" or \"v\"");
  endswitch
  
  refCODList = refCODList/1000; # convert unit from [m] to [mm]
  
  if isfield(codRecord, "weights")
    dy = [];
    weights = codRecord.weights;
    for theName = refNameList
      if (isfield(weights, theName{1}))
        dy = [dy; weights.(theName{1})];
      else
        dy = [dy; 1];
      endif
    endfor
    dy = 1./dy;
    #dy = ones(length(refCODList), 1);
    [kickAngleResult, s] = wsolve(X, refCODList, dy);
  else
    kickAngleResult = X \ refCODList;
  endif
  
  ##== rearrage kickAngleResult to fit order of steererNames
  kickAngleList = [];
  steererValues = [];
  for i = 1:length(steererNames)
    kickerName = steererNames{i};
    for j = 1:length(stNameList)
      if (strcmp(kickerName, stNameList{j}))
        kickAngleList = [kickAngleList; kickAngleResult(j)];
        steererValues = [steererValues; 
        calcKickerValue(kickers.(kickerName), kickAngleResult(j), codRecord.brho)];
      endif
    endfor
  endfor
  codRecord.kickAngles = kickAngleList;
  codRecord.steererValues = steererValues;
  
  ##== setupt mommentum error
  switch (codRecord.horv)
    case "h"
      codRecord.pError = kickAngleResult(end);
    case "v"
      codRecord.pError = 0;
    otherwise
      error("codRecord.horv must be \"h\" or \"v\"");
  endswitch
  
endfunction