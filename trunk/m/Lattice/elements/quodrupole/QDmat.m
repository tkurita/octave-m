## -- usage : matrix = QDmat(strQ)
##
## make a matrix of defocusing quadrupole magnet
##
##= Parameters
## strQ mast have following fields
##  .qk -- focusing structure per length
##  .length or .efflen -- effective length of magnet

function matrix = QDmat(strQ)
  len = fieldLength(strQ);
  sqk = sqrt(abs(strQ.k));
  matrix = [
  cosh(sqk*len), (1/sqk)*sinh(sqk*len), 0;
  sqk*sinh(sqk*len), cosh(sqk*len), 0;
  0, 0, 1];  
endfunction