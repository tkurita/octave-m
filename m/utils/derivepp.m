## -*- texinfo -*-
## @deftypefn {Function File} {} derivepp(@var{pp})
##
## Make a pice-wise polunominal of a derivative of @var{pp}
##
## @end deftypefn

##== History
## 2009-06-26
## * first implementation

function retval = derivepp(pp)
  [x, p, n, k, d] = unmkpp(pp);
  for m = 1:rows(p)
    dp(m,:) = polyderiv(p(m,:));
  endfor
  retval = mkpp(x, dp, d);
endfunction

%!test
%! ppderive(x)
