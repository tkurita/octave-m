## -*- texinfo -*-
## @deftypefn {Function File} {@var{lattice_rec} =} 
##    process_lattice(@var{lattice_rec}, [@var{full_circle_mat}])
##
## @deftypefnx {Function File} {[@var{beta_function}, @var{dispersion},@var{total_phase}, @var{all_elements}] =} 
##                process_lattice(@var{lattice_rec}, [@var{full_circle_mat}])
## 
## The argument @var{lattice_rec} is a cell array consisted of element structures or a structure which have field 'lattice' of a cell array.
## 
## If @var{full_circle_mat} is ommited, it will be calculated internally with function 'calcFullCircle'.
##
## Follwing fields are append each element structure in @var{all_elements}.
##
## @table @code
## @item entranceTwpar.h and .v
## Twiss parameter at the entrance of the element.
## [beta; alpha; gamma]
## 
## @item centerTwpar.h and .v
## @item exitTwpar.h and .v
##
## @item exitDispersion
## @item entranceBeta.h and .v
## @item centerBeta.h and .v
## @item exitBeta.h and .v
## @item entrancePosition
## @item centerPosition
## @item exitPosition
## item descriptions
## @end table
## 
## @seealso{calcFullCircle, calc_lattice}
## @end deftypefn

## usage: 
## [betaFunction, dispersion, totalPhase, all_elements] 
##                        = process_lattice(all_elements [,fullCircleMat])
## or
## latticeRec = process_lattice(all_elements [,fullCircleMat])
## 
##
##== Parameters
## * all_elements   -- 全要素の matrix の配列
## * fullCircleMat -- all_elements をすべて掛け合わせたもの。
##                    水平方向と垂直方向を別々にcalcFullCircle を使って計算する。
##              .h -- 水平方向 一周分の matrix
##              .v -- 垂直方向 一周分の matrix
##
##== Results
## * betafunction -- beta function
## * dispersion -- 分散
##          all_elements{n}.eater(1) のリスト n番目の要素の出口の dispersion
##
## * totalPhase -- 一周で進む beta function の位相を計算する。
##
## * all_elements : following fields are added to each elements
##    .twpar : twiss parameter at exit of the element.
##        .h : horizontal
##        .v : vertical
##    .centerTwpar : twiss parameter at center of the element.
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
##  .lattice -- cell array, equivalent to all_elements
##  .tune.h
##  .tune.v


##== History
## 2008-06-18
## use initial_twiss_parameters instead of twissParameter
## 
## 2007-10-25
## * add entranceTwpar field
## * rename twpar field into exitTwpar
## 
## 2007-10-18
## * accept lattice_rec as an argument.
## * renamed from calcLattice
##
## 2007-10-16
## * centerTwpar field instead of centerTwpar 
##
## 2006.10.12
## * fullCircleMat を与えなくてもいいようにした。
## * nargout == 1 のとき、latticeRec を返すようにした。

function varargout = process_lattice(varargin)
  if (isstruct(varargin{1}))
    lattice_rec = varargin{1};
    all_elements = lattice_rec.lattice;
  else
    all_elements = varargin{1};
  endif
  
  if (length(varargin) > 1)
    fullCircleMat = varargin{2};
  else
    fullCircleMat.h = calcFullCircle(all_elements, "h");
    fullCircleMat.v = calcFullCircle(all_elements, "v");
  endif
  
  ##== set initile twiss parameter of horizontal
  twPcosMu.h = initial_twiss_parameters(fullCircleMat.h);
  twp0.h = twPcosMu.h.twp;
  pretwp.h = twp0.h;
  
  ##== set initial dispersion
  cosmu.h = twPcosMu.h.cosmu;
  eater0 = getDispersion(fullCircleMat.h, cosmu.h);
  preeater = eater0;
  
  ##== set initiale twiss parameter of vertical
  twPcosMu.v = initial_twiss_parameters(fullCircleMat.v);
  twp0.v = twPcosMu.v.twp;
  pretwp.v = twp0.v;
  
  ##== dispersion and twiss parameter at exit of each element.
  thePosition = 0;
  totalPhase.h = 0;
  totalPhase.v = 0;
  
  betaFunction.h = [thePosition,twp0.h(1)];
  betaFunction.v = [thePosition,twp0.v(1)];
  dispersion = [thePosition,eater0(1)];
  
  for n = 1:length(all_elements)
    theElement = all_elements{n};
    
    ##== twpar.(h or v) : definition of twiss parameter
    ## (1) beta function
    ## (2) alpha
    ## (3) gamma
    
    ##=== at entrance
    theElement.entranceTwpar = pretwp;
    ##=== full, at exit
    theElement.exitTwpar.h = theElement.twmat.h*pretwp.h;
    theElement.exitTwpar.v = theElement.twmat.v*pretwp.v;
    theElement.twpar = theElement.exitTwpar; # obsolete
    ##=== half, at center
    theElement.centerTwpar.h = theElement.twmat_half.h*pretwp.h;
    theElement.centerTwpar.v = theElement.twmat_half.v*pretwp.v;
    
    ##== horizontal beta function
    theElement.entranceBeta.h = pretwp.h(1);
    theElement.exitBeta.h = theElement.twpar.h(1);
    theElement.centerBeta.h = theElement.centerTwpar.h(1);
    theElement.meanBeta.h = (theElement.entranceBeta.h+theElement.exitBeta.h)/2; #obsolete
    
    ##== vertical beta function
    theElement.entranceBeta.v = pretwp.v(1);
    theElement.exitBeta.v = theElement.twpar.v(1);
    theElement.centerBeta.v = theElement.centerTwpar.v(1);
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
    all_elements{n} = theElement;
    pretwp.h = theElement.twpar.h;
    pretwp.v = theElement.twpar.v;
    preeater = theElement.eater;
  endfor
  
  if (nargout > 1)
    varargout = {betaFunction, dispersion, totalPhase, all_elements};
  else
    lattice_rec.tune.v = totalPhase.v/(2*pi);
    lattice_rec.tune.h = totalPhase.h/(2*pi);
    lattice_rec.lattice = all_elements;
    lattice_rec.totalPahase = totalPhase;
    varargout = {lattice_rec};
  endif
  
endfunction

function s = centerPosition(theElement)
  s = (theElement.entrancePosition + theElement.exitPosition)/2;
endfunction
