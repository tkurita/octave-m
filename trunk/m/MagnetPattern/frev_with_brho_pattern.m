## -*- texinfo -*-
## @deftypefn {Function File} {@var{frev} =} frev_with_brho_pattern(@var{brhos}, @var{C}, @var{particle}, @var{q}, @var{h}, @var{f0})
##
## Obtain pattern of revolution frequency from B*rho pattern.
## B*rho pattern give frequency changes and added to @var{f0}.
## 
## @strong{Inputs}
## @table @var
## @item @var{brhos}
## Pattern of B*rho value.
## @item @var{partile}
## kind of particle.
## @item @var{q}
## charge number.
## @item @var{h}
## harmonics number.
## @item @var{f0}
## caputure frequency.
## @end table
##
## @strong{Outputs}
## @table @var
## @item @var{frev}
## revolution frequency [Hz]
## @end table
##
## @end deftypefn

##== History
## 2012-10-25
## * added to shared function files.

function frev = frev_with_brho_pattern(brhos, C, particle, q, h, f0)
frev = [];
pref = f0;
m0c2 = mass_energy(particle)*1e6;
lv = physical_constant("SPEED_OF_LIGHT_IN_VACUUM");
dbrho = diff(brhos);

for n = 1:length(dbrho)
  bt = pref*C/(h*lv);
  gm = abs(1/sqrt(1-bt^2));
  df = (h/C)*q*lv^2/(m0c2 *(gm + bt^2*(1-bt^2)^(-3/2)))*dbrho(n);
  pref = pref+df;
  frev(end+1) = pref;
end
endfunction

%!test
%! frev_pattern(x)
