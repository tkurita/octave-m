## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} velocity_with_erho(@var{erho}, amu, charge)
##
## @end deftypefn

##== History
##

function retval = velocity_with_erho(erho, amu, charge)
  emass = mass_energy(amu)*1e6;
  erhoz = erho*charge;
  b = sqrt((- erhoz^2 + sqrt(erhoz^4 + 4*emass^2*erhoz^2))/(2*emass^2));
  c = physical_constant("SPEED_OF_LIGHT_IN_VACUUM");
  retval = b*c;
endfunction

%!test
%! velocity_with_erho(3.6486e+08, 1, 1)
