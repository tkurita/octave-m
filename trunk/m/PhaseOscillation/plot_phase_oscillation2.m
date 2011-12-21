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

##==History
## 2011-01-25
## * fixed conversion from [rad/sec] to [kHz]
## 2011-01-07
## * reimplemented for Octave 3.2
## * renamed from plotPhaseOsillation2.m

function plot_phase_oscillation2(tline,bline,bPoints_set,vlist,omega_s,phi_s,e_area2)
  # bPoints_set = bp;
  # phi_s = ps;
  #   
  bline_set = [tline,bline];
  vline_set = [tline,vlist];
  phi_s_set = [tline, phi_s .*360./(2*pi)];
  e_area2_set = [tline, e_area2] ; #[msec; 10 eV sec]
  omega_s_set = [tline, omega_s*1e-3/(2*pi)];
  
  subplot(2,1,1);
  ax = xyyplot({omega_s_set, "-;synchrotorn frequency [KHz];",...
                phi_s_set, "-;phase angle of synchronus particle [degree];"},...
                {e_area2_set, "-r;bucket Area;"});...
  ylabel(ax(1), "synchrotorn Frequency [KHz]\nphase angle [degree]");...
  ylabel(ax(2), "RF bucket area [eV*sec]");
  subplot(2,1,2);
  ax = xyyplot({bline_set, "-;BM Pattern;", bPoints_set, "*"},...
               {vline_set, "-g;RF Voltage;"});...
  ylabel(ax(1), "BL value of BM [T*m]");...
  ylabel(ax(2), "RF Voltage [V]");...
  ylim(ax(2), [0,450]);xlabel("Time [msec]");

endfunction
