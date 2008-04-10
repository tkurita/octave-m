##
## = Parameters
## * lineRec -- a structure which have folloing fields
##  .x
##  .y
##  .c

function result = nxForNy(nyList, lineRec)
  if (lineRec.x == 0)
    lineRec
    error("lineRec.x is zero.");
  else
    x0 = lineRec.c/lineRec.x;
    result = x0 - (lineRec.y/lineRec.x).*nyList;
  endif
endfunction