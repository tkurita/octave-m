## -*- texinfo -*-
## @deftypefn {Function File} {} DTmat(@var{property_struct})
## @deftypefnx {Function File} {} DTmat(@var{len})
## 
## Return a matrix of a drift tube of which length is @var{dl} [m].
##
## @seealso{DT}
##
## @end deftypefn

##== History
## 2007-11-24
## * accept a structure as an argument 

function matrix = DTmat(argin)
  if (isstruct(argin))
    dl = argin.len;
  else
    dl = argin;
  endif
  
  matrix =...
  [1, dl, 0;
  0, 1, 0;
  0, 0, 1];
endfunction