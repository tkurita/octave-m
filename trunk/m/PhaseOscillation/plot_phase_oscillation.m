## -*- texinfo -*-
## @deftypefn {Function File} {} plot_phase_oscillation(@var{tline}, @var{bline}, @var{bpoints}, @var{vlist}, @var{ws}, @var{deltaEFromB}, @var{e_area}, @var{d_emac}, @var{nM}, @var{totalEnergy}, @var{phi1})
## plot ...
## @itemize
## @item synchrotron frequency and Phase angle of synchronus particle.
## @item bucket height, bucket Area in dE-phi coordinate.
## @item pattern of bending magnet and RF voltage.
## @end itemize
##
## @strong{Inputs}
## @table @var
## @item vlist
## RF Voltage Pattern
## @item bline
## pattern of bending magnet
## @item ws
## synchrotron frequency in [rad/sec]
## @end table
##
## @end deftypefn

##= History
## 2011-01-25
## * fixed conversion from [rad/sec] to [kHz]
## 2011-???
## * reimplemented for Octave 3.2
## * renamed from plotPhaseOsillation

function plot_phase_oscillation(tline,bline,bPoints_set,vlist,ws,phi_s,deltaEFromB,e_area, d_emax,nM,totalEnergy,phi1)
  # phi_s = ps;
  # deltaEFromB = d_e;
  # totalEnergy = Ee;
  # nM = mass;
  # bPoints_set = bp;
  
  #global lv; # light velocity
  m0c2 = mass_energy(nM);

  bline_set = [tline, bline];
  vLine_set = [tline, vlist];
  phi_s_set = [tline, phi_s .*360./(2*pi)];
  deltaEFromB_set = [tline, deltaEFromB*1e-3]; #[msec; keV]
  d_emax_set = [tline, d_emax*1e-3]; #[msec; keV]
  e_area_set = [tline, e_area/10000]; #[msec; 10 keV]
  ws_set = [tline, ws./(2*pi)*1e-3];
  # kEList = totalEnergy - nM*proton_eV; #Kinetic Energy
  kEList = totalEnergy - m0c2*1e6; #Kinetic Energy

  relative_e_area_set = [tline, (e_area./(kEList*4*pi)).*100]; #[msec; %]

  subplot(3,1,1);
  ax = xyyplot({ws_set, "-;synchrotorn Frequency [KHz];"},...
               {phi_s_set, "-g;phase angle of synchronus particle [degree];"});...
  ylabel(ax(1), "synchrotorn Frequency [kHz]");...
  ylabel(ax(2), "phase angle [degree]");
  #tickslabel_off(ax(1), "x");  
  subplot(3,1,2);
  ax = xyyplot(
      {d_emax_set, "-;RF bucket height [KeV];",...
        e_area_set, "-;Bucket Area [10 KeV];",...
        deltaEFromB_set, "-r;Energy gain/1 BClocl [KeV];"},...
      {relative_e_area_set, "-c;Relative Bucket Area [%];"});...
  ylabel(ax(1), "Bucket Height [KeV]\nBucket Area [10KeV]");...
  ylabel(ax(2), "Relative Bucket Area [%]");
  #tickslabel_off("x");
  subplot(3,1,3);
  ax = xyyplot({bline_set,"-;BM Pattern;", bPoints_set, "*"},...
              {vLine_set, "-g;RF Voltage;"}, "linecolor", "green");...
  ylabel(ax(1), "BL value of BM [T m]");...
  ylabel(ax(2), "RF Voltage [V]");...
  ylim(ax(2), [0,500]);xlabel("Time [msec]");

  #print_pdf("phase_oscillation.pdf", "fontsize", 10, "papersize", [8, 10])

endfunction
