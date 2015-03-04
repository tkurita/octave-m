## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} dnu_second(@var{arg})
##
## Calc of tune shift of 2nd term of expanded by action
##  (amplitude of betatron oscillation).
## The distribution is gaussian.
##
## @table @samp
## @item @var{N}
## Number of particles
##
## @item @var{gm}
## (total every)/(energy of static mass)
##
## @item @var{Bf}
## bunching fuctor typicaly 0.3.
## 
## @item @var{betaf}
## A vector of mean betatoron fuction.
## 
## @item @var{sig}
## A vector of standard deviation of beam distribution.
## 
## @item @var{jac}
## A vector of action of betatron oscillation.
## 
## @end table
##
## @end deftypefn

##== History
## 2010-09-13
## * First implementation.

function retval = dnu_second(N, gm, Bf, betaf, sig, jac)
  beta2 = 1 -1/(gm^2);
  rp = 1.5305e-18; # protorn classical radius [m]
  retval = (N*rp/(2*pi*beta2*gm^3*Bf))...
         *((2*sig(1)+sig(2))*betaf(1)^2*jac(1)/(4*sig(1)^3*(sig(1)+sig(2)))...
           + betaf(1)*betaf(2)*jac(2)/(2*sig(1)*sig(2)*(sig(1)+sig(2))^2));
endfunction

%!test
%! func_name(x)
