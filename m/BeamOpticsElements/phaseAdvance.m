function phaseDelta = phaseAdvance(theMat,twPar)
  phaseDelta = atan(theMat(1,2)/(theMat(1,1)*twPar(1)-theMat(1,2)*twPar(2)));
endfunction
