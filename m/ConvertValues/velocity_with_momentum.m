## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} velocity_with_momentum(@var{p}, @var{particle})
##
## @table @var
## @item p
## momentum [MeV/m]
## @item particle
## The kind of the particle. "proton", "helium", "carbon" or mass number.
##
## @item @var{charge}
## charge number.
## @end table
##
## @end deftypefn

##== History
## 2011-02-16
## * First Implementation.

function retval = velocity_with_momentum(p, particle)
  if nargin < 2
    print_usage();
  endif
  mass_e = mass_energy(particle);
  lv = physical_constant("SPEED_OF_LIGHT_IN_VACUUM");
  x = lv*p/mass_e; # beta/(sqrt(1-beta^2))
  b2 = x.^2./(1+x.^2);
  retval = sqrt(b2)*lv;
endfunction

%!test
%! velocity_with_momentum(momentum_with_mev(200, "proton"))
