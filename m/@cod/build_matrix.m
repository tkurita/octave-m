## -*- texinfo -*-
## @deftypefn {Function File} {@var{mat_struct} =} build_matrix(@var{cod}, ["full"])
## make a matrix structure for fitting COD by kickers.
##
## @strong{Options}
## @table @code
## @item full
## Make a matrix for full circle, when given. 
## Use this option when calculated COD.
## Don't use option for fitting with kickers.
## @end table
##
## @strong{Required field of Input}
## @table @code
## @item kickers
## @item horv
## @item kick_angles
## @item ring.lattice
## @item ring.brho
## @item ring.tune
## @end table
##
## @strong{Fields of Output}
## @table @code
## @item mat
## product with kick_angles give COD
## @item dispersion
## dipersion at BPM
## @item kickers
## order of kickers, cell array of element structures
## @item monitors
## a cell array of names of monitors. sorted with the order in lattice.
## @item refCOD
## appended when "full" option is not given.
## @item positions
## appended when "full" option is given.
## @end table
## 
## @seealso{cod, apply_kick_angles}
## @end deftypefn

##= History
## 2013-11-27
## * ported from buildCODMatrix

function result = build_matrix(cod_obj, varargin);
  kicker_names = cod_obj.kickers;
  horv = cod_obj.horv;
  ring = cod_obj.ring;
  lattice = ring.lattice;
  brho = ring.brho;
  tune = ring.tune;
  
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
    for n = 1 : length(kicker_names)
      if (strcmp(lattice{m}.name, kicker_names{n}))
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
      if (isfield(cod_obj.at_bpms, elementName))
        refPhaseList = [refPhaseList, currentElement.centerPhase.(horv)];
        refBetaList = [refBetaList, currentElement.centerBeta.(horv)];
        refDispersionList = [refDispersionList; currentElement.centerDispersion];
        refCODList = [refCODList; cod_obj.at_bpms.(elementName)];
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