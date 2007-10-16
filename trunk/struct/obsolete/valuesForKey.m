## usage:array = valuesForKey(cellArray, keyPath [, outputCellArray]) 
##
##= Parameters 
## * cellArray -- cell array which elements are structures.
## * KeyPath -- cell array of strings which are path of field of structure
## * outputCellArray (optional) -- if same value is given, cell array is output instead of matrix
##
##= result
## row-wise matrix or cell array of cellArray{i}.(keyPath{1}).(keyPath{2})...

function array = valuesForKey(cellArray, keyPath, varargin)
  #	cellArray = allElements
  isOutCells = (length(varargin) > 0);
  if (isOutCells)
    array = {};
  else
    array = [];
  endif
  #	keyPath={"exitPhase","h"};
  for n = 1:length(cellArray)
    theValue = cellArray{n};
    for i = 1:length(keyPath)
      theKey = keyPath{i};
      theValue = theValue.(theKey);
    endfor
    if (isOutCells)
      array = {array{:}, theValue};
    else
      array = [array, theValue(:)];
    endif
  endfor
endfunction

#valuesForKey(allElements,  {"exitPhase","h"})
