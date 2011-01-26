## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} conductance_rect(@var{dx},@var{dy},@var{l})
##
## @table @code
## @item @var{dx}
## width
## @item @var{dy}
## height
## @item @var{l}
## length
## @end table
## @end deftypefn

##== History
##

function retval = conductance_rect(dx, dy, l)
  k = coeff_rect(dx, dy);
  retval = 309*k*dx^2*dy^2/((dx+dy)*l);
endfunction

%!test
%! conductance_rect(2,10, 1)
