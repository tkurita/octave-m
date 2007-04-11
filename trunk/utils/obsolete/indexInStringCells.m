## cellidx ‚ðŽg‚¤
function result = indexInStringCells(cellArray, theValue)
  result = 0;
  for n = 1:length(cellArray)
    if (strcmp(theValue, cellArray{n}))
      result = n;
      break;
    endif
  endfor
endfunction
