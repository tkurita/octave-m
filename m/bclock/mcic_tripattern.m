## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} mcic_tripattern(@var{arg})
## description
## @strong{Inputs}
## @table @var
## @item arg1
## description of @var{arg}
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## description of @var{retval}
## @end table
##
## @end deftypefn

##== History
##

function retval = mcic_tripattern(P, N, m, pattern)
  xfliped = flipud(pattern(:));
  x = [xfliped; pattern(:); xfliped];
  x2 = notch_mcic_filter(P, N, m, x);
  l = length(pattern);
  gd = P*(m/2)*(N/P-1);
  retval = x2(l+1+gd: 2*l+gd);
endfunction

%!test
%! func_name(x)
