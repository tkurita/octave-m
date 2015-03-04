## -*- texinfo -*-
## @deftypefn {Function File} {@var{frev} =} frev_pattern(@var{bl}, @var{C}, @var{particle}, @var{q}, @var{h}, @var{f0})
##
## Obtain pattern of revolution frequency from BL pattern.
## BL pattern give frequency changes and added to @var{f0}.
## 
## @strong{Inputs}
## @table @var
## @item @var{bl}
## Pattern of BL value.
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
## added to shared function files.

function frev = frev_pattern(bl, C, particle, q, h, f0)
if nargin < 1
  print_usage();
endif
frev = [];
pref = f0;
m0c2 = mass_energy(particle)*1e6;
lv = physical_constant("speed of light in vacuum");
dbl = diff(bl);

for n = 1:length(dbl)
  bt = pref*C/(h*lv);
  gm = abs(1/sqrt(1-bt^2));
  df = (h/C)*q*lv^2/(m0c2 *(gm + bt^2*(1-bt^2)^(-3/2)))*dbl(n)/(pi/4);
  pref = pref+df;
  frev(end+1) = pref;
end
endfunction

%!test
%! frev_pattern(x)
