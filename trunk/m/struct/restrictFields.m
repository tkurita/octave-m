## usage : obj = restrictFields(obj, fields)
##
## remove fields excepted fileds fiven by argument "fields" from obj
##
## = Parameters
## * obj (structure)
## * fields (cell array)
##
## = Result
## structure

function obj = restrictFields(obj, fields)
  for [val, key] = obj
    if (!containStr(fields, key))
      obj = rmfield(obj, key);
    endif
  endfor
endfunction
