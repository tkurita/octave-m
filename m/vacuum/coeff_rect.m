## -*- texinfo -*-
## @deftypefn {Function File} {@var{k} =} coeff_rect(@var{dx}, @var{dy})
## 
## Correction coeffecient k of the conductance of the rectancular duct.
##
## C = 309*k*dx^2*dy^2*/((dx+dy)*l)
##
## 真空ハンドブック P39
## @end deftypefn

##== History
##

function retval = coeff_rect(dx, dy)
  
  if (dx > dy)
    r = dy/dx;
  else
    r = dx/dy;
  endif
  
  ktable = [ ...
    1, 1.115;
    2/3, 1.127;
    1/2, 1.149;
    1/3, 1.199;
    1/5, 1.290;
    1/8, 1.398;
    1/10, 1.456];
  
  retval = interp1(ktable(:,1), ktable(:,2), r, "linear", "extrap");
  
endfunction

%!test
%! func_name(x)
