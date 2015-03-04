## usage: 
## [betaFunction,dispersion,totalPhase,allElements] 
##                        = calcLattice(allElements,fullCircleMat)
##
## betafunction: beta function
## dispersion: 分散
##          allElements{n}.eater(1) のリスト n番目の要素の出口の dispersion
##
## totalPhase: 一周で進む beta function の位相
## を計算する。
## また、計算の過程で allElements の各成分に
## twpar.h: twiss parameter 水平
## twpar.v: twiss parameter 垂直
## eater: 分散
## の field が付け加えられる。
## 
## allElements: 全要素の matrix の配列
## fullCircleMat: allElements をすべて掛け合わせたもの。
##                水平方向と垂直方向を別々にcalcFullCircle を使って計算する。
function [betaFunction,dispersion,totalPhase,allElements]\
	  = calcLattice(allElements)

  ## set initile twiss parameter of horizontal
  twPcosMu.h = twissParameter(fullCircleMat.h);
  twp0.h = twPcosMu.h.twp;
  pretwp.h = twp0.h;
  
  ## set initial dispersion
  cosmu.h = twPcosMu.h.cosmu;
  eater0 = getDispersion(fullCircleMat.h,cosmu.h);
  preeater = eater0;
  
  ## set initiale twiss parameter of vertical
  twPcosMu.v = twissParameter(fullCircleMat.v);
  twp0.v = twPcosMu.v.twp;
  pretwp.v = twp0.v;
  
  ## dispersion and twiss parameter at exit of each element.
  thePosition = 0;
  totalPhase.h = 0;
  totalPhase.v = 0;
  
  betaFunction.h = [thePosition,twp0.h(1)];
  betaFunction.v = [thePosition,twp0.v(1)];
  dispersion = [thePosition,eater0(1)];
  
  for n = 1:length(allElements)
 	theElement = allElements{n};
 	theElement.twpar.h = theElement.twmat.h*pretwp.h;
 	theElement.twpar.v = theElement.twmat.v*pretwp.v;
	## twpar.(h or v) : twiss parameter
	## (1) beta function
	## (2) alpha
	## (3) gamma
	theElement.entranceBeta.h = pretwp.h(1);
	theElement.exitBeta.h = theElement.twpar.h(1);
	theElement.meanBeta.h = (theElement.entranceBeta.h+theElement.exitBeta.h)/2;

	theElement.entranceBeta.v = pretwp.v(1);
	theElement.exitBeta.v = theElement.twpar.v(1);
	theElement.meanBeta.v = (theElement.entranceBeta.v+theElement.exitBeta.v)/2;

	theElement.entranceDispersion = preeater(1);
 	theElement.eater = theElement.mat.h*preeater;
	theElement.exitDispersion = theElement.eater(1);
	theElement.meanDispersion = (theElement.entranceDispersion+theElement.exitDispersion)/2;

	theElement.entrancePosition = thePosition;
 	thePosition = thePosition + theElement.len;
	theElement.exitPosition = thePosition;
	theElement.centerPosition = centerPosition(theElement);

 	## beta function
 	betaFunction.h = [betaFunction.h;thePosition,theElement.twpar.h(1)];
 	betaFunction.v = [betaFunction.v;thePosition,theElement.twpar.v(1)];

 	## dispersion
 	dispersion =[dispersion;thePosition,theElement.eater(1)];
	
 	## total phase advance
	theElement.entrancePhase.h = totalPhase.h;
 	totalPhase.h = totalPhase.h + phaseAdvance(theElement.mat.h,pretwp.h);
	theElement.exitPhase.h = totalPhase.h;
	theElement.centerPhase.h = (theElement.entrancePhase.h + theElement.exitPhase.h)/2;

 	theElement.entrancePhase.v = totalPhase.v;
	totalPhase.v = totalPhase.v + phaseAdvance(theElement.mat.v,pretwp.v);
	theElement.exitPhase.v = totalPhase.v;
	theElement.centerPhase.v = (theElement.entrancePhase.v + theElement.exitPhase.v)/2;

 	## prepare next calculation
 	allElements{n} = theElement;
 	pretwp.h = theElement.twpar.h;
 	pretwp.v = theElement.twpar.v;
 	preeater = theElement.eater;
  end
endfunction

function s = centerPosition(theElement)
  s = (theElement.entrancePosition + theElement.exitPosition)/2;
endfunction
