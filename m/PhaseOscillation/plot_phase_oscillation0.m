## -*- texinfo -*-
## @deftypefn {Function File} {} plot_phase_oscillation0(@var{tline}, @var{bline}, @var{bpoints}, @var{vlist}, @var{ws}, @var{ps})
## plot ...
## @itemize
## @item synchrotron frequency and Phase angle of synchronus particle.
## @item pattern of bending magnet and RF voltage.
## @end itemize
##
## @strong{Inputs}
## @table @var
## @item tline
## time [msec]
## @item bline
## BM pattern
## @item bpoints
## @end table
##
## @end deftypefn

function plot_phase_oscillation0(tline,bline,bPoints_set,vlist,omega_s,phi_s)
  if ! nargin
    print_usage();
  endif
  clf; # if no clf, next plot will be invalid.
  pm = stacked_plot("margin");
  pm(3) = pm(1);
  stacked_plot("margin", pm);
  stacked_plot(2,1);
  ax = plotyy(tline, omega_s*1e-3/(2*pi), tline, phi_s .*360./(2*pi)); grid on;
  ylabel(ax(1), "synchrotorn Frequency [kHz]");
  ylabel(ax(2), "phase angle [degree]");
  tickslabel_off(ax, "x");
  stacked_plot(2,2);
  ax = plotyy(tline, vlist, tline, bline); grid on;
  ylabel(ax(1), "RF Voltage [V]");
  ylabel(ax(2), "BM Pattern");
  ylim(ax(1), [0,450]);
  hold on;
  plot(ax(2), bPoints_set(:,1), bPoints_set(:,2), "*")
  hold off;
  xlabel("Time [msec]");
endfunction

%!test
%! func_name(x)
