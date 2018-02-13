## find(ismember(c, s) を使う。
## cellidx を使う -- version 3.4 から obsolute
function result = indexInStringCells(cellArray, theValue)
  result = 0;
  for n = 1:length(cellArray)
    if (strcmp(theValue, cellArray{n}))
      result = n;
      break;
    endif
  endfor
endfunction
