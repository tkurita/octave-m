## -*- texinfo -*-
## @deftypefn {Function File} mev_with_frev(@var{frev}, @var{circumference}, @var{particle})
##
## Calculate the kinetic energy [MeV] of the particle of given revolution frequency.
## It is assumed that the harmonics is 1.
##
## @table @code
## @item @var{frev}
## Revolution frequency [Hz]
##
## @item @var{circumference}
## Circumference of the ring [m]
##
## @item @var{particle}
## The kind of the particle. "proton", "helium", "carbon" or mass number.
## @end table
##
## @end deftypefn

##== History
## 2008-03-03
## * renamed from frevToMeV
 
function result = mev_with_frev(frev, circumference, particle)
  mass_e = mass_energy(particle);
  v = frev * circumference; #[m/s]
  lv = physical_constant("SPEED_OF_LIGHT_IN_VACUUM");
  b = v/lv;
  g = 1/sqrt(1-b^2);
  result = mass_e*(g - 1);
endfunction

%!test
%! mev_with_frev(5106250, 33.201, "proton")
# ans =  199.37
# PASSES 1 out of 1 tests
