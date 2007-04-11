function result = nyForNx(nxList, lineRec)
  if (lineRec.y == 0)
    lineRec
    error("lineRec.y is zero.");
  else
    y0 = lineRec.c/lineRec.y;
    result = y0 - (lineRec.x/lineRec.y).*nxList;
  endif
endfunction