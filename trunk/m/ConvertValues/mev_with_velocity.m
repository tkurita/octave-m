## -*- texinfo -*-
## @deftypefn {Function File} {} mev_with_velocity(@var{v}, @var{particle})
##
## @table @code
## @item @var{v}
## velocity [m/s]
## @item @var{particle}
## "proton", "helium", "carbon" or mass number [a.m.u.]
## @end table
##
## @end deftypefn

##== History
## 2008-08-20
## * first implementation

function retval = mev_with_velocity(v, particle)
  mass_e = mass_energy(particle);
  lv = physical_constant("SPEED_OF_LIGHT_IN_VACUUM");
  b = v/lv;
  g = 1/sqrt(1-b^2);
  retval = mass_e*(g - 1);
endfunction

%!test
%! mev_with_velocity(x)
