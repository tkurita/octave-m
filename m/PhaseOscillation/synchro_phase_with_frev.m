## -*- texinfo -*-
## @deftypefn {Function File} {@var{ps} =} synchro_phase_with_frev(@var{frev}, @var{rfv}, @var{tsec}, @var{C}, @var{particle}, @var{q})
## Evaluate synchronus phase with revolution frequency.
## @strong{Inputs}
## @table @var
## @item frev
## revolution frequency. The hamonics is assumed as 1.
## Therefor @var{frev} should be RF frequency/harmonics.
## @item rfv
## RF voltage pattern.
## @item tsec
## time in seconds.
## @item C
## circumference [m], 33.201 m for WERC
## @end table
##
## @strong{Outputs}
## @table @var
## @item ps
## synchronus phase in radian.
## @end table
##
## @end deftypefn

function [ps, sin_ps] = synchro_phase_with_frev(frev, rfv, tsec, C, particle, q)
  if ! nargin
    print_usage();
  endif
  dfdt = gradient(frev, tsec);
  m0c2 = mass_energy(particle)*1e6;
  lv = physical_constant("speed of light in vacuum");
  sin_ps = (m0c2./(q*rfv)).*(1- (C*frev/lv).^2).^(-3/2)*(C/lv)^2.*dfdt;
  sin_ps(isnan(sin_ps)) = 0;
  ps = asin(sin_ps);
endfunction

%!test
%! synchro_phase_with_frev(x)
