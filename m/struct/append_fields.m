## usage : a_struct = append_fields(astruct, varargin)
##
## = Example
## s.a = 1
## b = 1
## s = append_fields(s, b)

function a_struct = append_fields(a_struct, varargin)
  for n = 2:nargin
    a_struct.(deblank(inputname(n))) = varargin{n-1};
  endfor
  
endfunction
