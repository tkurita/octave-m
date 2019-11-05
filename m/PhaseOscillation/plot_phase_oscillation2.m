## -*- texinfo -*-
## @deftypefn {Function File} {} plot_phase_oscillation2(@var{tline}, @var{bline}, @var{bpoints}, @var{vlist}, @var{ws}, @var{ps}, @var{e_area2})
## plot ...
## @itemize
## @item synchrotron frequency and Phase angle of synchronus particle.
## @item bucket area in dR/(h omega)-phi coordinate.
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

function plot_phase_oscillation2(tline,bline,bPoints_set,vlist,omega_s,phi_s,e_area2)
  # bPoints_set = bp;
  # phi_s = ps;
  stacked_plot(2,1);
  ax = plotyy(tline, [omega_s*1e-3/(2*pi), phi_s .*360./(2*pi)] ...
              , tline, e_area2);
  ylabel(ax(1), "synchrotorn Frequency [KHz]\nphase angle [degree]");
  ylabel(ax(2), "RF bucket area [eV*sec]");
  legend("synchrotorn frequency [KHz]" ...
        , "phase angle of synchronus particle [degree]" ...
        , "bucket Area");
  tickslabel_off(ax, "x");
  stacked_plot(2,2);
  ax = plotyy(tline, bline ...
              , tline, vlist);
  ylabel(ax(1), "BL value of BM [T*m]");
  ylabel(ax(2), "RF Voltage [V]");
  legend("BM Pattern", "RF Voltage");
  ylim(ax(2), [0,450]);xlabel("Time [ms]");
endfunction
