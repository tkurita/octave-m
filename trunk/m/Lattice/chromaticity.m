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
## 2008-06-02
## * BM does not contribute chromaticity.
## * Edges of BMs are considered.
##
## 2008-04-24
## * Use is_BM instead of isBendingMagnet
## 
## 2007-10-26
## * help with texinfo format
## * accept lattice_rec structure

function chrom = chromaticity(lattice_rec)
  if (isstruct(lattice_rec))
    allElements = lattice_rec.lattice;
  else
    allElements = lattice_rec;
  endif
    
  betaList.h = [];
  betaList.v = [];
  klList.h = [];
  klList.v = [];
  for n = 1:length(allElements)
    ##if (regexp(allElements{n}.name, "^QD"))
#      klList.h(end+1) = focusingPower(allElements{n}, "h");
#      klList.v(end+1)= focusingPower(allElements{n}, "v");
#      betaList.v(end+1) = allElements{n}.centerBeta.v;
#      betaList.h(end+1) = allElements{n}.centerBeta.h;
#    endif

    if (is_BM(allElements{n}))
      klList.h(end+1) = allElements{n}.edgeK.h;
      klList.h(end+1) = allElements{n}.edgeK.h;
      klList.v(end+1) = allElements{n}.edgeK.v;
      klList.v(end+1) = allElements{n}.edgeK.v;
  
      betaList.h(end+1) = allElements{n}.entranceBeta.h;
      betaList.h(end+1) = allElements{n}.exitBeta.h;
      betaList.v(end+1) = allElements{n}.entranceBeta.v;
      betaList.v(end+1) = allElements{n}.exitBeta.v;
#    endif
      
    else
      klList.h(end+1) = focusingPower(allElements{n}, "h");
      klList.v(end+1)= focusingPower(allElements{n}, "v");
      betaList.v(end+1) = allElements{n}.centerBeta.v;
      betaList.h(end+1) = allElements{n}.centerBeta.h;
    endif

  endfor
  
  chrom.h = -sum(klList.h .* betaList.h)/(4*pi);
  chrom.v = -sum(klList.v .* betaList.v)/(4*pi);
endfunction