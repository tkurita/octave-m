## -*- texinfo -*-
## @deftypefn {Function File} {@var{dE} =} dE_with_dp_p(@var{dpp}, @var{E}, @var{paricle})
## Evaluate energy variation correlated with momentum variation.
## @strong{Inputs}
## @table @var
## @item dpp
## dp/p : momentum error
## @item E
## kinetic energy in MeV
## @end table
##
## @strong{Outputs}
## @table @var
## @item dE
## energy error in MeV
## @end table
##
## @end deftypefn

function dE = dE_with_dp_p(dpp, E, particle)
  if ! nargin
    print_usage();
  endif
  mass_e = mass_energy(particle);
  lv = physical_constant("speed of light in vacuum");
  w = mass_e + E; # total energy
  b2 = 1- (mass_e/w)^2;
  #dE = b2*dpp*E;
  dE = b2*dpp*w;
endfunction

%!test
%! func_name(x)
