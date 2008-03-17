## -*- texinfo -*-
## @deftypefn {Function File} {} mev_with_momentum(@var{p}, @var{particle})
##
## Evaluate Kinetic energy from momentum
##
## @table @code
## @item @var{p}
## momentum [MeV/c]
##
## @item @var{particle}
## The kind of the particle. "proton", "helium", "carbon" or mass number.
##
## @end table
## @end deftypefn

##== History
## 2008-03-17
## * first implementaion

function result = mev_with_momentum(p, particle)
  mass_e = mass_energy(particle);
  lv = physical_constant("SPEED_OF_LIGHT_IN_VACUUM");
  x = p/(mass_e*c) # beta/(sqrt(1-beta^2))
  b2 = x/(1+x);
  g = 1/sqrt(1-b2);
  result = mass_e(g-1);
endfunction