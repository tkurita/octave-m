## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} conductance_circle(@var{d},@var{l})
##
## @table @code
## @item @var{d}
## diameter
## @item @var{l}
## length
## @end table
## @end deftypefn

##== History
##

function retval = conductance_circle(d, l)
  k = coeff_circle(d,l);
  retval = k*116*(pi*(d/2)^2);
endfunction

%!test
%! conductance_circle(2,10)
