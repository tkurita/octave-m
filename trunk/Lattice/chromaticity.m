## usage : chrom = chromaticity(allElements)
##
##= Result
## chrom have following fields.
##    .v : vertical chromaticity
##    .h : horizontal chromaticity

function chrom = chromaticity(allElements)
#  kList.h = [];
#  kList.v = [];
#  lengthList = [];
  betaList.h = [];
  betaList.v = [];
  klList.h = [];
  klList.v = [];
  for n = 1:length(allElements)
    klList.h = [klList.h; focusingPower(allElements{n}, "h")];
    klList.v = [klList.v; focusingPower(allElements{n}, "v")];
    
#    kList.h = [kList.h; allElements{n}.k.h];
#    kList.v = [kList.v; allElements{n}.k.v];
#    lengthList = [lengthList; allElements{n}.len];
    
    betaList.v = [betaList.v; allElements{n}.centerBeta.v];
    betaList.h = [betaList.h; allElements{n}.centerBeta.h];
    
    if (isBendingMagnet(allElements{n}))
#      kList.h = [kList.h; allElements{n}.edgeK.h; allElements{n}.edgeK.h];
#      kList.v = [kList.v; allElements{n}.edgeK.v; allElements{n}.edgeK.v];
#      lengthList = [lengthList; 1; 1];

      klList.h = [klList.h; allElements{n}.edgeK.h; allElements{n}.edgeK.h];
      klList.v = [klList.v; allElements{n}.edgeK.v; allElements{n}.edgeK.v];
  
      betaList.h = [betaList.h; allElements{n}.entranceBeta.h; allElements{n}.exitBeta.h];
      betaList.v = [betaList.v; allElements{n}.entranceBeta.v; allElements{n}.exitBeta.v];
      
    endif
  endfor
  
#  chrom.h = -sum(kList.h .* betaList.h.*lengthList)/(4*pi);
#  chrom.v = -sum(kList.v .* betaList.v.*lengthList)/(4*pi);
  chrom.h = -sum(klList.h .* betaList.h)/(4*pi);
  chrom.v = -sum(klList.v .* betaList.v)/(4*pi);
endfunction