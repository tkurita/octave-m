## -- usage : matrix = QFmat(strQ)
##
## make a matrix of focusing quadrupole magnet
##
##= Parameters
## strQ mast have following fields
##  .qk -- focusing structure per length
##  .length or .efflen -- effective length of magnet

function matrix = QFmat(strQ)
  len = field_length(strQ);
  sqk = sqrt(abs(strQ.k));
  matrix = [
  cos(sqk*len), (1/sqk)*sin(sqk*len), 0;
  -sqk*sin(sqk*len), cos(sqk*len), 0;
  0, 0, 1];
endfunction
