## usage:array = value_for_keypath(struct or array of struct, 
##                                 keypath [, as_cells]) 
##
##== Parameters
## * cellarray -- cell array which elements are structures.
## * keypath -- cell array of strings which are path of field of structure
## * as_cells (optional) -- if true is given, cell array is output 
##                                 instead of matrix
##
##== result
## row-wise matrix or cell array of cellarray{i}.(keypath{1}).(keypath{2})...

function array = value_for_keypath(cellarray, keypath, varargin)
  #	cellarray = allElements
  isOutCells = (length(varargin) > 0);
  if (isOutCells)
    array = {};
  else
    array = [];
  endif
  
  #	keypath={"exitPhase","h"};
  if (ischar(keypath))
    keys = split(keypath, ".");
    keypath = cellfun(@deblank...
      , mat2cell(keys, ones(1, rows(keys)), columns(keys))...
      , "UniformOutput", false);
  endif
  
  if (isstruct(cellarray))
    cellarray = {cellarray};
  endif
  
  for n = 1:length(cellarray)
    a_struct = cellarray{n};
    for m = 1:length(keypath)
      a_key = keypath{m};
      a_struct = a_struct.(a_key);
    endfor
    if (isOutCells)
      array = {array{:}, a_struct};
    else
      array = [array, a_struct(:)];
    endif
  endfor
endfunction

#value_for_keypath(allElements,  {"exitPhase","h"})
