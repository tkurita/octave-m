## -*- texinfo -*-
## @deftypefn {Function File} {} ppgrad(@var{pp}, @var{x})
##
## Return gradients of a pice-wise polunominal @var{PP} at @var{x}.
##
## @end deftypefn

##== History
## 2009-06-26
## * first implementation

function retval = ppgrad(pp, x)
  dpp = derivepp(pp);
  retval = ppval(dpp, x);
endfunction

%!test
%! ppderive(x)
