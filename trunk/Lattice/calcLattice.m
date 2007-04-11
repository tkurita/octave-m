## usage: 
## [betaFunction, dispersion, totalPhase, allElements] 
##                        = calcLattice(allElements [,fullCircleMat])
## or
## latticeRec = calcLattice(allElements [,fullCircleMat])
##
## = Parameters
## * allElements   -- 全要素の matrix の配列
## * fullCircleMat -- allElements をすべて掛け合わせたもの。
##                    水平方向と垂直方向を別々にcalcFullCircle を使って計算する。
##              .h -- 水平方向 一周分の matrix
##              .v -- 垂直方向 一周分の matrix
##
## = Results
## * betafunction -- beta function
## * dispersion -- 分散
##          allElements{n}.eater(1) のリスト n番目の要素の出口の dispersion
##
## * totalPhase -- 一周で進む beta function の位相を計算する。
##
## * allElements -- following fields are added to each elements
##    .twpar.h -- twiss parameter 水平
##    .twpar.v -- twiss parameter 垂直
##    .exitDispersion -- dispersion at the exit of the element
##
##    .entranceBeta 
##    .exitBeta
##    .centerBeta
##
##    .entrancePosition
##    .centerPosition
##    .exitPosition
##
## if the number of out arguments is 1, latticeRec will be return, 
## which is a structure with following field.
##  .lattice -- cell array, equivalent to allElements
##  .tune.h
##  .tune.v


## = History
## 2006.10.12 -- fullCircleMat を与えなくてもいいようにした。
##               nargout == 1 のとき、latticeRec を返すようにした。

function [varargout] = calcLattice(allElements, varargin)
  if (length(varargin) > 1)
    fullCircleMat = varargin{1};
  else
    fullCircleMat.h = calcFullCircle(allElements, "h");
    fullCircleMat.v = calcFullCircle(allElements, "v");
  endif
  
  ##== set initile twiss parameter of horizontal
  twPcosMu.h = twissParameter(fullCircleMat.h);
  twp0.h = twPcosMu.h.twp;
  pretwp.h = twp0.h;
  
  ##== set initial dispersion
  cosmu.h = twPcosMu.h.cosmu;
  eater0 = getDispersion(fullCircleMat.h, cosmu.h);
  preeater = eater0;
  
  ##== set initiale twiss parameter of vertical
  twPcosMu.v = twissParameter(fullCircleMat.v);
  twp0.v = twPcosMu.v.twp;
  pretwp.v = twp0.v;
  
  ##== dispersion and twiss parameter at exit of each element.
  thePosition = 0;
  totalPhase.h = 0;
  totalPhase.v = 0;
  
  betaFunction.h = [thePosition,twp0.h(1)];
  betaFunction.v = [thePosition,twp0.v(1)];
  dispersion = [thePosition,eater0(1)];
  
  for n = 1:length(allElements)
    theElement = allElements{n};
    
    ##== twpar.(h or v) : definition of twiss parameter
    ## (1) beta function
    ## (2) alpha
    ## (3) gamma
    ##=== full
    theElement.twpar.h = theElement.twmat.h*pretwp.h;
    theElement.twpar.v = theElement.twmat.v*pretwp.v;
    ##=== half
    theElement.twpar_half.h = theElement.twmat_half.h*pretwp.h;
    theElement.twpar_half.v = theElement.twmat_half.v*pretwp.v;
    
    ##== horizontal beta function
    theElement.entranceBeta.h = pretwp.h(1);
    theElement.exitBeta.h = theElement.twpar.h(1);
    theElement.centerBeta.h = theElement.twpar_half.h(1);
    theElement.meanBeta.h = (theElement.entranceBeta.h+theElement.exitBeta.h)/2; #obsolute
    
    ##== vertical beta function
    theElement.entranceBeta.v = pretwp.v(1);
    theElement.exitBeta.v = theElement.twpar.v(1);
    theElement.centerBeta.v = theElement.twpar_half.v(1);
    theElement.meanBeta.v = (theElement.entranceBeta.v+theElement.exitBeta.v)/2; #obsolute
    
    ##== dispersion
    theElement.entranceDispersion = preeater(1);
    theElement.eater = theElement.mat.h*preeater;
    theElement.exitDispersion = theElement.eater(1);
    
    theElement.meanDispersion = (theElement.entranceDispersion+theElement.exitDispersion)/2; #obsolute
    
    theElement.eater_center = theElement.mat_half.h*preeater;
    theElement.centerDispersion = theElement.eater_center(1);
    
    ##== posiotns (entrance, exit, center)
    theElement.entrancePosition = thePosition;
    thePosition = thePosition + theElement.len;
    theElement.exitPosition = thePosition;
    theElement.centerPosition = centerPosition(theElement);
    
    ##== build beta function list
    betaFunction.h = [betaFunction.h;thePosition,theElement.twpar.h(1)];
    betaFunction.v = [betaFunction.v;thePosition,theElement.twpar.v(1)];
    
    ##== build dispersion list
    dispersion =[dispersion;thePosition,theElement.eater(1)];
    
    ##== total phase advance
    ##=== horizontal
    theElement.entrancePhase.h = totalPhase.h;
    theElement.centerPhase.h = totalPhase.h + phaseAdvance(theElement.mat_half.h, pretwp.h);
    totalPhase.h = totalPhase.h + phaseAdvance(theElement.mat.h, pretwp.h);
    theElement.exitPhase.h = totalPhase.h;
    #theElement.centerPhase.h = (theElement.entrancePhase.h + theElement.exitPhase.h)/2;
    
    ##=== vertical
    theElement.entrancePhase.v = totalPhase.v;
    theElement.centerPhase.v = totalPhase.v + phaseAdvance(theElement.mat_half.v, pretwp.v);
    totalPhase.v = totalPhase.v + phaseAdvance(theElement.mat.v, pretwp.v);
    theElement.exitPhase.v = totalPhase.v;
    #theElement.centerPhase.v = (theElement.entrancePhase.v + theElement.exitPhase.v)/2;
    
    ##== prepare next calculation
    allElements{n} = theElement;
    pretwp.h = theElement.twpar.h;
    pretwp.v = theElement.twpar.v;
    preeater = theElement.eater;
  endfor
  
  if (nargout > 1)
    varargout = {betaFunction, dispersion, totalPhase, allElements};
  else
    tune.v = totalPhase.v/(2*pi);
    tune.h = totalPhase.h/(2*pi);
    lattice = allElements;
    varargout = {tar(lattice, totalPhase, tune)};
  endif
  
endfunction

function s = centerPosition(theElement)
  s = (theElement.entrancePosition + theElement.exitPosition)/2;
endfunction
