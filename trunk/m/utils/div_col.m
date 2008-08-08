## -*- texinfo -*-
## @deftypefn {Function File} {} div_col(@var{x})
##
## Divide matrix @var{x} into columns.
##
## @example
## x = [1,2,3];
## [a, b, c] = div_col(x);
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
## 2008-08-05
## * first implementation

function varargout = div_col(x)
  for n = 1:nargout
    varargout{n} = x(:,n);
  endfor
endfunction