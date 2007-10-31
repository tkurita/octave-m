## -*- texinfo -*-
## @deftypefn {Function File} {@var{chrom_rec} =} chromaticity(@var{lattice_rec})
##
## The output @var{chrom_rec} have following fields.
## @table @code
## @item h
## horizontal chromaticity
## @item v
## vertical chromaticity
## @end table
##
## @end deftypefn

##== History
## 2007-10-26
## * help with texinfo format
## * accept lattice_rec structure

function chrom = chromaticity(lattice_rec)
  if (isstruct(lattice_rec))
    allElements = lattice_rec.lattice;
  else
    allElements = lattice_rec;
  endif
    
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