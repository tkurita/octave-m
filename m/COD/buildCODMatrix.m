## Usage : codRecord = buildCODMatrix(codRecord [,"full"]);
##      using linear least square method ??
##
##= Parameters
## * codRecord (structure) 
##    .steererNames
##    .horv
##    .lattice
##    .brho
##    .tune
## * "full" -- make a matrix for full circle, when given
##             use this option when calculated COD
##             don't use option for fitting with steerer values
##
##= Results
## structture with following field
##     .mat -- product with kickAngles give COD
##     .dispersion -- dipersion at BPM
##     .kickers -- order of kickers, cell array of element structures
##     .monitors -- cell array of names of monitor 
##                  sorted with the order in lattice
##  with "full" option
##     .postions
##  without "full" option
##     .refCOD -- given when "full" is not specified.

##= History
## 2007.07.12
## * add .monitors field to result
##
## 2006.08.18
## * make
##

function result = buildCODMatrix(codRecord, varargin);
  steererNames = codRecord.steererNames;
  
  lattice = codRecord.lattice;
  brho = codRecord.brho;
  tune = codRecord.tune;
  horv = codRecord.horv;
  isFullRange = false;
  if (length(varargin) > 0)
    isFullRange = strcmp(varargin{1}, "full");
  endif
  
  ## pick up steerer parameters
  stBetaList = []; # beta function at center position of steerers
  stPhaseList = []; # phase advance at center position of steerers
  kickers = {};
  for m = 1:length(lattice)
    currentElement = lattice{m};
    for n = 1 : length(steererNames)
      if (strcmp(lattice{m}.name, steererNames{n}))
        stPhaseList = [stPhaseList, currentElement.centerPhase.(horv)];
        stBetaList = [stBetaList, currentElement.centerBeta.(horv)];
        kickers = {kickers{:}, lattice{m}};
        break;
      endif
    endfor
  endfor
  
  ## pick up reference points parameters
  refBetaList = []; # beta function at center position of reference elements
  refPhaseList = []; # phase advance at center position of reference elements
  refDispersionList = []; # dispersion at center positon of reference elements
  refNameList = {};
  if (isFullRange)
    positions = [];
    for n = 1:length(lattice)
      currentElement = lattice{n};
      refPhaseList = [refPhaseList ...
        , currentElement.centerPhase.(horv), currentElement.exitPhase.(horv)];
      refBetaList = [refBetaList ...
        , currentElement.centerBeta.(horv), currentElement.exitBeta.(horv)];
      refDispersionList = [refDispersionList ...
        ; currentElement.centerDispersion; currentElement.exitDispersion];
      positions = [positions ...
        ; currentElement.centerPosition; currentElement.exitPosition];
    endfor
    result.positions = positions;
  else
    refCODList = [];
    for n = 1:length(lattice)
      currentElement = lattice{n};
      elementName = currentElement.name;
      if (isfield(codRecord.codAtBPM, elementName))
        refPhaseList = [refPhaseList, currentElement.centerPhase.(horv)];
        refBetaList = [refBetaList, currentElement.centerBeta.(horv)];
        refDispersionList = [refDispersionList; currentElement.centerDispersion];
        refCODList = [refCODList; codRecord.codAtBPM.(elementName)];
        refNameList{end+1} = elementName;
      endif
    endfor
    result.refCOD = refCODList;
  endif
  nst = length(stBetaList);
  nref = length(refBetaList);
  X = repmat(sqrt(refBetaList'),1,nst).* repmat(sqrt(stBetaList), nref, 1);
  cosX = cos(pi*tune.(horv) - abs(repmat(refPhaseList',1,nst) - repmat(stPhaseList,nref,1)));
  result.mat = X.*cosX/(2*sin(pi*tune.(horv)));
  result.dispersion = refDispersionList;
  result.kickers = kickers;
  result.monitors = refNameList;
endfunction