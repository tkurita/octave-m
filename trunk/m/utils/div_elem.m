## -*- texinfo -*-
## @deftypefn {Function File} {} div_elem(@var{x})
##
## Divide matrix @var{x} into elements.
##
## @example
## x = [1,2,3];
## [a, b, c] = div_elem(x);
## @end example
##
## is same to
##
## @example
## a = x(1)
## b = x(2)
## c = x(3)
## @end example
## 
## @end deftypefn

##== History
## 2009-06-12
## * accept cells
## 2008-08-05
## * first implementation

function varargout = div_elem(x)
  if nargout > length(x)
    error("Number of output arguments is few.");
  endif
  if iscell(x)
    for n = 1:nargout
      varargout{n} = x{n};
    endfor
  else
    for n = 1:nargout
      varargout{n} = x(n);
    endfor
  endif
endfunction