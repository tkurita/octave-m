## retval = colwise(v1, v2, ....)
##
## Convert vectors v1, v2 .. into column-wise.
## and assemble these into a matrix 'retval'
##
## This is useful to make a xy data from two vectors.

function retval = colwise(varargin)
  retval = [];
  for n = 1:length(varargin)
    retval(:,n) = varargin{n}(:);
  endfor
endfunction
