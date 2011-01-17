## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} coherent_tuneshift_by_element(@var{elem})
## 
## @table @code
## @item @var{elem}
## element
## @item @var{R}
## R = circumfernece/(2*pi) 33.2/(2*pi) = 5.28394411065
## @item @var{bt}
## Lorenz factor v/c
## @item @var{Bf}
## bunching factor ~0.3
## @item @var{N}
## Number of particles
## @end table
##
## @end deftypefn

##== History
## 2009-10-28
## * initial implementation

function retval = coherent_tuneshift_by_element(elem, C, bt, Bf, N, eqname)
  eta = 0;  
  avgb = average_beta(elem);
  ic = image_coefficients(elem);
  gm = 1/sqrt(1-bt^2);
  r = 1.53e-18; # classical radius
  l = elem.len;
  R = C/(2*pi);
  if (strcmp(elem.kind, "BM"))
    g = 55e-3/2;
  else
    g = inf;
  endif
  h = elem.duct.ymax;
  switch (eqname)
    case ("Zotter")
      retval.h = - (l/C)*(N*r*avgb.h/(pi*gm*bt^2))*(...
                    (ic.ep1.h/h^2 + ic.ep2.h/g^2)...
                    + (ic.xi1.h/h^2)*(1-bt^2-eta)/Bf);
      retval.v = - (l/C)*(N*r*avgb.v/(pi*gm*bt^2))*(...
                    (ic.ep1.v/h^2 + ic.ep2.v/g^2)...
                    + (ic.xi1.v/h^2)*(1-bt^2-eta)/Bf);               
    case ("CERN1") # near an integral resonance
      F1.h = ic.xi1.h*(1+Bf*(gm^2-1)) + ic.xi2.h*Bf*(gm^2-1)*h^2/g^2;
      F1.v = ic.xi1.v*(1+Bf*(gm^2-1)) + ic.xi2.v*Bf*(gm^2-1)*h^2/g^2;
      F = F1;
      retval.h = - (l/C)*(N*r*F.h*avgb.h)/(pi*h^2*gm^3*bt^2*Bf);
      retval.v = - (l/C)*(N*r*F.v*avgb.v)/(pi*h^2*gm^3*bt^2*Bf);      
    case ("CERN2") # near a half-integral resonance
      F2.h = ic.xi1.h*(1+Bf*(gm^2-1)) + ic.xi2.h*Bf*(gm^2-1)*h^2/g^2;
      F2.v = ic.xi1.v*(1+Bf*(gm^2-1)) + ic.xi2.v*Bf*(gm^2-1)*h^2/g^2;
      F = F2;
      retval.h = - (l/C)*(N*r*F.h*avgb.h)/(pi*h^2*gm^3*bt^2*Bf);
      retval.v = - (l/C)*(N*r*F.v*avgb.v)/(pi*h^2*gm^3*bt^2*Bf);      
    otherwise # "CERN"
  endswitch
endfunction

%!test
%! func_name(x)
