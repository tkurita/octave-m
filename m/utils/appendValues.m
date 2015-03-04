function s = appendValues(s, varargin)
  for n = 2:nargin
    s.(deblank(argn(i,:))) = varargin{n};
  endfor
endfunction

    