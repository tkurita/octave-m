## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} dp_p_with_dE_E(@var{dE}, @var{E0}, @var{particle})
## description
## @strong{Inputs}
## @table @var
## @item E0
## reference kinetic energy
## @item dE
## small change of kinetic energy
## @item particle
## name of particle or mass number
## @end table
##
## @strong{Outputs}
## dp/p = W dE/(W^2 - m0^2c^4)
##
## @end deftypefn

##== History
## 2016-01-28
## * first implementataion

function retval = dp_p_with_dE_E(dE, E0, particle)
  if (!nargin)
    print_usage();
    return;
  endif
#  p0 = momentum_with_mev(E0, particle);
#  p1 = momentum_with_mev(E0+dE, particle);
#  retval = (p1-p0)/p0;
  m0c2 = mass_energy(particle);
  w = E0 + m0c2; # total energy
  retval = w/(w^2-m0c2^2)*dE;
endfunction

%!test
%! dp_p_with_dE_E(15e-3, 20, "carbon")
%! printf("result should be close to : 3.7527e-04 \n");


