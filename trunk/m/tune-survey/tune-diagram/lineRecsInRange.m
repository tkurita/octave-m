## usage : lineRecList = lineRecsInRange(lineCoeff, nxrange, nyrange)
##      共鳴線の係数 lineCoeff を使って、range の範囲におさまる共鳴線を求める
##
## = Parameters
## * lineCoeff -- 判定したい係数の候補
##  
## = Result
## lineRecList is cell array of structure lineRec. lineRec have following fields.
##  .x  -- .x nx + .y ny = c
##  .y
##  .c
##  .isNoCouple -- true if both of .x and .y are not zero
##  .resoOrder
##  .plotData

function lineRecList = lineRecsInRange(lineCoeff, nxrange, nyrange)
  #lineCoeff = [2;-2];
  isNoCouple = !all(lineCoeff);
  resoOrder = sum(abs(lineCoeff));
  
  if (isNoCouple)
    if (lineCoeff(1) == 0)
      theRange = nyrange;
      theCoeff = lineCoeff(2);
    else
      theRange = nxrange;
      theCoeff = lineCoeff(1);
    endif
    
    rtInRange = (ceil(min(theRange)*theCoeff):floor(max(theRange)*theCoeff));
    if (resoOrder > 1)
      rtInRange = removeInVector(rtInRange, resoOrder);
    endif
    
    rtInRange = removeInVector(rtInRange, 0);
  else
    rTerm1 = lineCoeff(1)*nxrange(1) + lineCoeff(2)*nyrange;
    rTerm2 = lineCoeff(1)*nxrange(2) + lineCoeff(2)*nyrange;
    rTerm = [rTerm1(:);rTerm2(:)];
    rtInRange = ceil(min(rTerm)):floor(max(rTerm));
    
  endif
  
  isSum = lineCoeff(2) >= 0;
  lineRecList = {};
  for n = 1:length(rtInRange)
    #n=1
    x = lineCoeff(1);
    y = lineCoeff(2);
    c = rtInRange(n);
    if ((c > 1) && (abs(x) == abs(y)))
      if (mod(c, abs(x)) == 0)
        continue;
      endif
    endif
    
    newRec = tars(x, y, c, resoOrder, isNoCouple, isSum);
    if (y == 0)
      x0 = c/x;
      plotData = [[x0;x0], nyrange(:)];
    else
      yvalues = nyForNx(nxrange, newRec);
      plotData = [nxrange(:), yvalues(:)];
    endif
    if (!isNoCouple)
      if (all(yvalues >= max(nyrange)) || (all(yvalues <= min(nyrange))))
        continue;
      endif
      
      if ((max(yvalues) > max(nyrange)) && (min(yvalues) < min(nyrange)))
        xvalues = nxForNy(nyrange, newRec);
        plotData = [xvalues(:), nyrange(:)];
      endif
      
    endif
    
    newRec.plotData = plotData;
    lineRecList{end+1} = newRec;  
  endfor
  
endfunction
