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
## 2026-06-05
## * use end+1 instead of joining matrix
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
  nkickers = length(kicker_names);
  stBetaList = NA(1, nkickers); # beta function at center position of steerers
  stPhaseList = NA(1, nkickers); # phase advance at center position of steerers
  kickers = cell(1, nkickers);
  for m = 1:length(lattice)
    currentElement = lattice{m};
    for n = 1 : nkickers
      kickername = kicker_names{n};
      if (strcmp(currentElement.name, kickername))
        stPhaseList(n) = currentElement.centerPhase.(horv);
        stBetaList(n) = currentElement.centerBeta.(horv);
        kickers(n) = lattice{m};
        break;
      elseif strcmp([currentElement.name "U"], kickername)
        # *U, *D indicate to insert kick at entrance or exit of the element
        stPhaseList(n) = currentElement.entrancePhase.(horv);
        stBetaList(n) = currentElement.entranceBeta.(horv);
        kickers(n) = struct("name", kickername);
      elseif strcmp([currentElement.name "D"], kickername)
        # *U, *D indicate to insert kick at entrance or exit of the element
        stPhaseList(n) = currentElement.exitPhase.(horv);
        stBetaList(n) = currentElement.exitBeta.(horv);
        kickers(n) = struct("name", kickername);
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
      # add center
      refPhaseList(end+1) = currentElement.centerPhase.(horv);
      refBetaList(end+1) = currentElement.centerBeta.(horv);
      refDispersionList(end+1) = currentElement.centerDispersion;
      positions(end+1) = currentElement.centerPosition;
      # add exit
      refPhaseList(end+1) = currentElement.exitPhase.(horv);
      refBetaList(end+1) = currentElement.exitBeta.(horv);
      refDispersionList(end+1) = currentElement.exitDispersion;
      positions(end+1) = currentElement.exitPosition;
    endfor
    result.positions = positions';
  else
    refCODList = [];
    for n = 1:length(lattice)
      currentElement = lattice{n};
      elementName = currentElement.name;
      if (isfield(cod_obj.at_bpms, elementName))
        refPhaseList(end+1) = currentElement.centerPhase.(horv);
        refBetaList(end+1) = currentElement.centerBeta.(horv);
        refDispersionList(end+1) = currentElement.centerDispersion;
        refCODList(end+1) = cod_obj.at_bpms.(elementName);
        refNameList{end+1} = elementName;
      endif
    endfor
    result.refCOD = refCODList';
  endif
  nst = length(stBetaList);
  nref = length(refBetaList);
  X = repmat(sqrt(refBetaList'),1,nst).* repmat(sqrt(stBetaList), nref, 1);
  cosX = cos(pi*tune.(horv) - abs(repmat(refPhaseList',1,nst) - repmat(stPhaseList,nref,1)));
  result.mat = X.*cosX/(2*sin(pi*tune.(horv)));
  result.dispersion = refDispersionList';
  result.kickers = kickers;
  result.monitors = refNameList;
endfunction