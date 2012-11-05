## -*- texinfo -*-
## @deftypefn {Function File} {} momentum_with_mev(@var{energy}, @var{particle})
## 
## Evaluate momentum [MeV/c] from the kinetic energy.
##
## @table @code
## @item @var{energy}
## Kinetic Energy [MeV]
##
## @item @var{particle}
## The kind of the particle. "proton", "helium", "carbon" or mass number.
## @end table
##
## @end deftypefn

##== History
## 2012-11-05
## * A constant name to give "pysical_constant is chagend due to specification change of pysical_constant.
## 2008-03-17
## * add texinfo help
## ????-??-??
## * renamed from momentumForMeV

function result = momentum_with_mev(energy, particle)
  mass_e = mass_energy(particle);
  lv = physical_constant("speed of light in vacuum");
  W= energy + mass_e; #total energy [MeV]
  result = (1/lv).*sqrt(W.^2 - mass_e.^2);
endfunction

%!test
%! momentum_with_mev(200, "proton")
#       ans =  2.1496e-06
# PASSES 1 out of 1 tests
