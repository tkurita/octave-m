## -*- texinfo -*-
## @deftypefn {Function File} {@var{cod} =} fit(@var{cod})
## fit cod with kickers using linear least square method.
##
## @strong{Inputs}
## @table @var
## @item arg1
## description of @var{arg}
## @end table
##
## @strong{Outputs} : following fields are appended.
## @table @code
## @item kick_angles
## kick angles by kickers to represent the COD.
## @item p_error
## momentum error.
## @end table
## 
## @seealso{}
## @end deftypefn


## Usage : cod_obj = lFitCOD(cod_obj);
##
## using linear least square method
##
##= Parameters
## * cod_obj (structure) 
##    .kicker_names
##    .horv
##    .lattice
##    .brho
##    .tune
##    .at_bpms
##    [.ignorePerror] -- 運動量誤差を fitting parameter に含めるかどうか。省略時 false
##
##= Results
## following fields are appended.
##     .kick_angles
##     .p_error

##= History
## 2013-11-26
## * move from lFitCOD


function cod_obj = fit(cod_obj, varargin);
  if length(varargin)
    cod_obj = set(cod_obj, varargin{:});
  endif
  kicker_names = cod_obj.kickers;
  horv = cod_obj.horv;

  ring = cod_obj.ring;
  allElements = ring.lattice;
  brho = ring.brho;
  tune = ring.tune;
  
  ##== pick up steerer parameters
  stBetaList = []; # beta function at center position of steerers
  stPhaseList = []; # phase advance at center position of steerers
  stNameList = {};
  for m = 1:length(allElements)
    currentElement = allElements{m};
    for n = 1 : length(kicker_names)
      if (strcmp(currentElement.name, kicker_names{n}))
        stPhaseList = [stPhaseList, currentElement.centerPhase.(horv)];
        stBetaList = [stBetaList, currentElement.centerBeta.(horv)];
        stNameList = {stNameList{:}, kicker_names{n}};
        kickers.(kicker_names{n}) = allElements{m};
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
    if (isfield(cod_obj.at_bpms, elementName))
      refPhaseList = [refPhaseList, currentElement.centerPhase.(horv)];
      refBetaList = [refBetaList, currentElement.centerBeta.(horv)];
      refDispersionList = [refDispersionList, currentElement.centerDispersion];
      refCODList = [refCODList; cod_obj.at_bpms.(elementName)];
      refNameList = {refNameList{:}, elementName};
    endif
  endfor
  nst = length(stBetaList);
  nref = length(refBetaList);
  X = repmat(sqrt(refBetaList'),1,nst).* repmat(sqrt(stBetaList), nref, 1);
  cosX = cos(pi*tune.(horv) - abs(repmat(refPhaseList',1,nst)...
                            - repmat(stPhaseList,nref,1)));
  
  switch (cod_obj.horv)
    case "h"
      X = [X.*cosX/(2*sin(pi*tune.(horv))), refDispersionList'];
    case "v"
      X = X.*cosX/(2*sin(pi*tune.(horv)));
    otherwise
      error("cod_obj.horv must be \"h\" or \"v\"");
  endswitch
  
  refCODList = refCODList/1000; # convert unit from [m] to [mm]
  
  if (isfield(cod_obj, "weights") && (length(refCODList) > 2))
    pkg load "optim"; # required for wsolve
    dy = [];
    weights = cod_obj.weights;
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
  
  ##== rearrage kickAngleResult to fit order of kicker_names
  kickAngleList = [];
  for i = 1:length(kicker_names)
    kickerName = kicker_names{i};
    for j = 1:length(stNameList)
      if (strcmp(kickerName, stNameList{j}))
        kickAngleList = [kickAngleList; kickAngleResult(j)];
      endif
    endfor
  endfor
  cod_obj.kick_angles = kickAngleList;
  
  ##== setupt mommentum error
  switch (cod_obj.horv)
    case "h"
      cod_obj.p_error = kickAngleResult(end);
    case "v"
      cod_obj.p_error = 0;
    otherwise
      error("cod_obj.horv must be \"h\" or \"v\"");
  endswitch
  
endfunction
