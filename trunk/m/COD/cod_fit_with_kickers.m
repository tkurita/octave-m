## Usage : cod_rec = cod_fit_with_kickers(cod_rec, kickers)
##  fit COD with given kickers 
##

##== History
## 2007-12-03
## * update obsolete functions

function cod_rec = cod_fit_with_kickers(cod_rec, kickers)
  cod_rec.steererNames = kickers;
  cod_rec = lFitCOD(cod_rec);
  cod_rec.correctCOD = cod_list_with_kickers(cod_rec);
endfunction
