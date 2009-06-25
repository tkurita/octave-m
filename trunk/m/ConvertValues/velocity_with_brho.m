## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} velocity_with_brho(@var{brho}, @var{particle}, @var{charge})
##
## @table @code
## @item @var{brho}
## [T*m]
## @item @var{particle}
## The kind of the particle. "proton", "helium", "carbon" or mass number.
##
## @item @var{charge}
## charge number.
## @end table
##
## @end deftypefn

##== History
## 2009-06-25
## * First Implementation.

function retval = velocity_with_brho(brho, particle, charge)
  if nargin < 3
    print_usage();
  endif
  mass_e = mass_energy(particle);
  p = charge.*brho.*1e-6; # [MeV/c]
  lv = physical_constant("SPEED_OF_LIGHT_IN_VACUUM");
  x = lv*p/mass_e; # beta/(sqrt(1-beta^2))
  b2 = x.^2./(1+x.^2);
  retval = sqrt(b2)*lv;
endfunction

%!test
%! velocity_with_brho(x)
