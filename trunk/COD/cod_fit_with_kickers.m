## Usage : cod_rec = cod_fit_with_kickers(cod_rec, kickers)
##  fit COD with given kickers 
##
function cod_rec = cod_fit_with_kickers(cod_rec, kickers)
  cod_rec.steererNames = kickers;
  cod_rec = lFitCOD(cod_rec);
  cod_rec.correctCOD = calcCODWithPerror(cod_rec);
endfunction
