## Usage : cod_rec = lFitCOD(cod_rec);
##
## using linear least square method
##
##= Parameters
## * cod_rec (structure) 
##    .steererNames
##    .horv
##    .lattice
##    .brho
##    .tune
##    .codAtBPM
##    [.ignorePerror] -- 運動量誤差を fitting parameter に含めるかどうか。省略時 false
##
##= Results
## following fields are appended.
##     .kickAngles
##     .steererValues
##     .pError

##= History
## 2008-04-24
## * Use ib_for_kickangle instead of calcKickerValue
##
## 2006-07-17
## * fitCOD(using non-linear least square method) と同じ結果が得られることを確認
##

function cod_rec = lFitCOD(cod_rec, varargin);
  steererNames = cod_rec.steererNames;
  
  allElements = cod_rec.lattice;
  brho = cod_rec.brho;
  tune = cod_rec.tune;
  horv = cod_rec.horv;
  
  ##== pick up steerer parameters
  stBetaList = []; # beta function at center position of steerers
  stPhaseList = []; # phase advance at center position of steerers
  stNameList = {};
  for m = 1:length(allElements)
    currentElement = allElements{m};
    for n = 1 : length(steererNames)
      if (strcmp(currentElement.name, steererNames{n}))
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
    if (isfield(cod_rec.codAtBPM, elementName))
      refPhaseList = [refPhaseList, currentElement.centerPhase.(horv)];
      refBetaList = [refBetaList, currentElement.centerBeta.(horv)];
      refDispersionList = [refDispersionList, currentElement.centerDispersion];
      refCODList = [refCODList; cod_rec.codAtBPM.(elementName)];
      refNameList = {refNameList{:}, elementName};
    endif
  endfor
  nst = length(stBetaList);
  nref = length(refBetaList);
  X = repmat(sqrt(refBetaList'),1,nst).* repmat(sqrt(stBetaList), nref, 1);
  cosX = cos(pi*tune.(horv) - abs(repmat(refPhaseList',1,nst) - repmat(stPhaseList,nref,1)));
  
  switch (cod_rec.horv)
    case "h"
      X = [X.*cosX/(2*sin(pi*tune.(horv))), refDispersionList'];
    case "v"
      X = X.*cosX/(2*sin(pi*tune.(horv)));
    otherwise
      error("cod_rec.horv must be \"h\" or \"v\"");
  endswitch
  
  refCODList = refCODList/1000; # convert unit from [m] to [mm]
  
  if isfield(cod_rec, "weights")
    dy = [];
    weights = cod_rec.weights;
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
        ib_for_kickangle(kickers.(kickerName), kickAngleResult(j), cod_rec.brho)];
      endif
    endfor
  endfor
  cod_rec.kickAngles = kickAngleList;
  cod_rec.steererValues = steererValues;
  
  ##== setupt mommentum error
  switch (cod_rec.horv)
    case "h"
      cod_rec.pError = kickAngleResult(end);
    case "v"
      cod_rec.pError = 0;
    otherwise
      error("cod_rec.horv must be \"h\" or \"v\"");
  endswitch
  
endfunction
