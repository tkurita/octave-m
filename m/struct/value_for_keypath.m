## -*- texinfo -*-
## @deftypefn {Function File} {@var{value} = } value_for_keypath(@var{a_struct}, @var{keypath})
## @deftypefnx {Function File} {@var{cell_or_mat} = } value_for_keypath(@var{cells}, @var{keypath} [, @var{as_cell}])
##
## @table @code
## @item @var{keypath}
## A cell array of strings which are path of field of structure. or string like key1.key2...
##
## @item @var{cells}
## cell array which elements are structures.
## 
## @item @var{as_cells}
## Optional. f true is given, cell array is output instead of matrix.
##
## @end table
##
## If the first argument is a cell array, the result is a row-wise matrix or a cell array of cellarray@{i@}.(keypath@{1@}).(keypath@{2@})...
## 
## @end deftypefn

##== History
## 2010-06-22
## * use strsplit(from 3.2) instead of split.
## 2008-04-11
## * Texinfo で help を書いた。

function array = value_for_keypath(cellarray, keypath, varargin)
  # cellarray = allElements
  isOutCells = (length(varargin) > 0);
  if (isOutCells)
    array = {};
  else
    array = [];
  endif
  
  # keypath={"exitPhase","h"};
  if (ischar(keypath))
#    keys = split(keypath, ".");
#    keypath = cellfun(@deblank...
#      , mat2cell(keys, ones(1, rows(keys)), columns(keys))...
#      , "UniformOutput", false);
    keypath = strsplit(keypath, ".");
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
