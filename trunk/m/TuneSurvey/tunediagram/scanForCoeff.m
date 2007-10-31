function lineRecList = scanForCoeff(lineCoeff, nxrange, nyrange)
  isNoCouple = !all(lineCoeff);
  if (isNoCouple)
    i = 1;
  else
    i = 0;
  endif
  resoOrder = sum(abs(lineCoeff));
  #outDirection = 0;
  posInRange = {};
  while (1)
    if (isNoCouple && (resoOrder == i))
      i++;
      continue;
    endif
    
    lineRec = struct("x",lineCoeff(1), "y",lineCoeff(2), "c", i);
    lineRec = isInArea(lineRec, nxrange, nyrange);
    outDirection = lineRec.outDirection;
      
    if (lineRec.isInRange)
      posInRange{end+1} = lineRec;
    else
      if ((lineCoeff(2) >= 0) && (outDirection == 1))
        break;
      elseif ((lineCoeff(2) < 0) && (outDirection == -1))
        break;
      endif
    endif
    
    i++;
  endwhile
  
  i = -1;
  #outDirection = 0;
  negInRange = {};
  while (1)
    lineRec = struct("x",lineCoeff(1), "y",lineCoeff(2), "c", i);
    lineRec = isInArea(lineRec, nxrange, nyrange)
    outDirection = lineRec.outDirection;
    if (lineRec.isInRange)
      negInRange = {lineRec, negInRange{:}};
    else
      if ((lineCoeff(2) >= 0) && (outDirection == -1))
        break;
      elseif ((lineCoeff(2) < 0) && (outDirection == 1))
        break;
      endif
    endif
    i--;
  endwhile
  
  lineRecList = [negInRange, posInRange];
  
  isSum = lineCoeff(2) >= 0;
#  if (isNoCouple)
#    # theCoeff ‚Ì‚Ç‚¿‚ç‚©‚ª 0 ‚¾‚Á‚½‚ç rtInange ‚©‚ç “¯‚¶Ÿ”‚ğœ‹
#    rtInRange = removeInVector(rtInRange, resoOrder);
#  endif
  
  for i = 1: length(lineRecList)
    lineRecList{i} = joinStruct(lineRecList{i}, tar(isNoCouple, resoOrder, isSum));
  endfor
endfunction


