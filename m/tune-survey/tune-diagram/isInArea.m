## * lineRec
##      .x
##      .y
##      .c
##  .x nx + .y ny = .c
##
## = results
## * .isInRange
## * .outDirection
##      -1 -- ny give small
##      0 -- the line cross the area
##      1 -- ny give big
function lineRec = isInArea(lineRec, nxrange, nyrange)
  #y0 = lineRec.c/lineRec.y;
  #y = y0 - (lineRec.x/lineRec.y).*nxrange;
  if (lineRec.y == 0)
    x = lineRec.c/lineRec.x;
    isUnderMax = x <= max(nxrange);
    isUpperMin = min(nxrange) <= x;
    isInRange = isUnderMax && isUpperMin;
    lineRec.plotData = [[x;x], nyrange(:)];
  else
    y = nyForNx(nxrange, lineRec);
    isUnderMax = y < max(nyrange);
    isUpperMin = min(nyrange) < y;
    
    isInRange = any(isUnderMax & isUpperMin);
    if (!isInRange)
      eqMax = (y == max(nyrange));
      eqMin = (y == min(nyrange));
      isInRange = (any(eqMax) && any(eqMin)) || (all(eqMax) || all(eqMin));
    end
    lineRec.plotData = [nxrange(:), y(:)];
  endif
  
  if (isInRange)
    outDirection = 0;
  else
    outDirection = !all(isUnderMax);
    if (outDirection)
      outDirection = 1;
    else
      outDirection = -1;
    endif
  endif

  lineRec = joinStruct(lineRec, tar(isInRange, outDirection));
endfunction
