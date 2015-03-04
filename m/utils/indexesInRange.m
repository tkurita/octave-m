## usage : result = indexesInRange(theVector, range)
##
## first index and last index that values in theVector is in range
##

function result = indexesInRange(theVector, range)
  result = [];
  isGreater = inline("a >= b");
  isLesser = inline("a <= b");
  if (range(1) < range(2))
    isBoundary = isGreater;
  else
    isBoundary = isLesser;
  endif
  
  ## scan for begin
  beginIndex = -1;
  for n = 1:length(theVector)
    if (isBoundary(theVector(n), range(1)))
      beginIndex = n;
      break;
    endif
  endfor
  
  if (beginIndex < 0)
    error("can't find begining index");
  endif
  
  ## scan for ending
  endIndex = -1;
  for n = beginIndex:length(theVector)
    if (isBoundary(theVector(n), range(2)))
      endIndex = n;
      break;
    endif
  endfor
  
  if (beginIndex < 0)
    error("can't find ending index");
  endif
  
  result = [beginIndex, endIndex];
endfunction