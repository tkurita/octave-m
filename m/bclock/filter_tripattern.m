## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} filter_tripattern(@var{arg})
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

function retval = filter_tripattern(h, pattern)
  xfliped = flipud(pattern(:));
  x = [xfliped; pattern(:); xfliped];
  x2 = filter(h, 1, x);
  gd = floor(-imag(polyval(-j*h.*(0:(length(h)-1)), 1)./polyval(h, 1)));
  l = length(pattern);
  retval = x2(l+1+gd: 2*l+gd);
endfunction

%!test
%! func_name(x)
