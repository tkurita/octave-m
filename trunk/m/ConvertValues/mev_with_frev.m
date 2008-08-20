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
## 2008-08-20
## * Use mev_with_velocity
## 
## 2008-03-03
## * renamed from frevToMeV
 
function retval = mev_with_frev(frev, circumference, particle)
  v = frev * circumference; #[m/s]
  retval = mev_with_velocity(v, particle);
endfunction

%!test
%! mev_with_frev(5106250, 33.201, "proton")
# ans =  199.37
# PASSES 1 out of 1 tests
