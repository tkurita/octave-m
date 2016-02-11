## -*- texinfo -*-
## @deftypefn {Function File} {@var{dpdt} =} dpdt_with_frev_pattern(@var{frev_t}, @var{a}, @var{C}, @var{particle})
##
## evaluate dp/dt 
##
## @strong{Inputs}
## @table @var
## @item frev_t
## two column matrix of [sec, frev]
## @item a
## mementum compaction factor.
## @item C
## circumference in [m]
## @item particle
## mass number or name of particle.
## @end table
##
## @strong{Outputs}
## @table @var
## @item dpdt
## time derivative of momentum in [MeV/c/s]
## @end table
##
## @seealso{dp_p_with_frev}
## @seealso{/Users/tkurita/WorkSpace/Synchrotron/2015-03 Bunch振動/0604/周回周波数の変化から運動量の変化を求める/df-to-dp.pdf}
## @end deftypefn

function dpdt = dpdt_with_frev_pattern(frev_t, a, C ,particle)
  if ! nargin
    print_usage();
  endif
  lv = physical_constant("speed of light in vacuum");
  b = C.*frev_t(:,2)./lv;
  g = 1./sqrt(1-b.^2);
  m0c2 = mass_energy(particle);
  dfdt = gradient(frev_t(:,2), frev_t(:,1));
  dpdt = (m0c2/lv^2)*C.*(g + b.^2.*(1 - b.^2).^(-3/2)).*dfdt;
  dpdt = [frev_t(:,1), dpdt];
endfunction

%!test
%! func_name(x)
