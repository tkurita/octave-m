## -*- texinfo -*-
## @deftypefn {Function File} {} DTmat(@var{dl})
## 
## Return a matrix of a drift tube of which length is @var{dl} [m].
##
## @seealso{DT}
##
## @end deftypefn

##= drift tube
## drift tube の matrix
## dl : drift tube の長さ

function matrix = DTmat(dl)
  matrix =...
  [1, dl, 0;
  0, 1, 0;
  0, 0, 1];
endfunction