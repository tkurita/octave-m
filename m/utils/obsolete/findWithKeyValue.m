## usage : result = findWithKeyValue(cellArray, keyPath, inValue)
## 
## find elements in cellArray whose value of keyPath is inValue
##
##= Parameters
## * cellArray -- cell array consite of structures
## * keyPath -- list of field names
##

function result = findWithKeyValue(cellArray, keyPath, inValue)
  result = {};
  
  for n = 1:length(cellArray)
    theCell = cellArray{n};
    for i = 1:length(keyPath)
      theKey = keyPath{i};
      theValue = theCell.(theKey);
    endfor
    try
      if (theValue == inValue)
        result = {result{:}, theCell};
      endif
    end_try_catch
  endfor
  
endfunction