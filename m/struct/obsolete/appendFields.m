## obsolute. use append_fields
##
## usage : astruct = appendFields(astruct, varargin)
##
## = Example
## s.a = 1
## b = 1
## s = appendFields(s, b)

function astruct = appendFields(astruct, varargin)
  astruct = append_fields(astruct, varargin);
endfunction
