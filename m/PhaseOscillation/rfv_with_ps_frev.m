## -*- texinfo -*-
## @deftypefn {Function File} {@var{rfv} =} rfv_with_ps_frev(@var{ps}, @var{frev}, @var{tsec}, @var{C}, @var{particle}, @var{q})
## Evaluate RF voltage from synchronus phase and revolution frequency.
##
## @strong{Inputs}
## @table @var
## @item ps
## synchronus phase in radian.
## @item frev
## revolution frequency. The hamonics is assumed as 1.
## Therefor @var{frev} should be RF frequency/harmonics.
## @item tsec
## time in seconds.
## @item C
## circumference [m], 33.201 m for WERC
## @end table
##
## @strong{Outputs}
## @table @var
## @item rfv
## RF voltage pattern [V].
## @end table
##
## @end deftypefn


function rfv = rfv_with_ps_frev(ps, frev, tsec, C, particle, q)
  if ! nargin
    print_usage();
  endif
  dfdt = gradient(frev, tsec);
  m0c2 = mass_energy(particle)*1e6;
  lv = physical_constant("speed of light in vacuum");
  rfv = (m0c2./(q*sin(ps))).*(1- (C*frev/lv).^2).^(-3/2)*(C/lv)^2.*dfdt;
endfunction

%!test
%! rfv_with_ps_frev(x)
