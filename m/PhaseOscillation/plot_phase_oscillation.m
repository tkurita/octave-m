## -*- texinfo -*-
## @deftypefn {Function File} {} plot_phase_oscillation(@var{tline}, @var{bline}, @var{bpoints}, @var{vlist}, @var{ws}, @var{deltaEFromB}, @var{e_area}, @var{d_emax}, @var{nM}, @var{totalEnergy})
## plot ...
## @itemize
## @item synchrotron frequency and Phase angle of synchronus particle.
## @item bucket height, bucket Area in dE-phi coordinate.
## @item pattern of bending magnet and RF voltage.
## @end itemize
##
## @strong{Inputs}
## @table @var
## @item tline
## @item bline
## pattern of bending magnet
## @item bPoints_set
## @item vlist
## RF Voltage Pattern
## @item ws
## synchrotron frequency in [rad/sec]
## @item phi_s
## synchronus phase [rad]
## @item deltaEFromB
## energy changes evaluated from BM field changes.
## @item e_area
## RF bucket area [eV]
## @item d_emax
## RF bucket hight [eV]
## @item nM
## mass number
## @item totalEnergy
## total energy [eV]
## @end table
##
## @end deftypefn

##= History
## 2018-03-09
## * removed phi1(unstabel fixed point), becuse it is not used.
## 2015-06-03
## * xyyplot が動作しない。
## * plotyy を使って再実装しようとしたが、subplot, legend などと相性が悪いらしく、
##   図が表示されない。原因不明。
## 2011-01-25
## * fixed conversion from [rad/sec] to [kHz]
## 2011-???
## * reimplemented for Octave 3.2
## * renamed from plotPhaseOsillation

function plot_phase_oscillation(tline,bline,bPoints_set,vlist,ws,phi_s,deltaEFromB,e_area, d_emax,nM,totalEnergy)
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
  stacked_plot("margin", [0.110000, 0.120000 , 0.110000, 0.100000])
  stacked_plot(3,1);
  ax = plotyy(tline, ws./(2*pi)*1e-3, tline, phi_s.*360./(2*pi));
#  ax = xyyplot({ws_set, "-;synchrotorn Frequency [KHz];"},...
#               {phi_s_set, "-g;phase angle of synchronus particle [degree];"});...
  ylabel(ax(1), "synchrotorn frequency [kHz]");
  ylabel(ax(2), "phase angle [degree]");
  legend("synchrotorn frequency [kHz]", "phase angle of synchronus particle [degree]");
  tickslabel_off(ax, "x");  
  stacked_plot(3,2);
#  ax = xyyplot(
#      {d_emax_set, "-;RF bucket height [KeV];",...
#        e_area_set, "-;Bucket Area [10 KeV];",...
#        deltaEFromB_set, "-r;Energy gain/1 BClocl [KeV];"},...
#      {relative_e_area_set, "-c;Relative Bucket Area [%];"});...
  ax = plotyy(tline, [d_emax*1e-3, e_area/10000, deltaEFromB*1e-3] ...
            , tline, (e_area./(kEList*4*pi)).*100);
  ylabel(ax(1), "Bucket Height [KeV]\nBucket Area [10KeV]");...
  ylabel(ax(2), "Relative Bucket Area [%]");
  # なぜか、legend を設定すると、図が消えちゃう。
  legend("RF bucket height [keV]", "Bucket Area [10 keV]" ...
          ,"Energy gain/1 BClocl [keV]", "Relative Bucket Area [%]");
  tickslabel_off(ax, "x"); 
  stacked_plot(3,3);
#  ax = xyyplot({bline_set,"-;BM Pattern;", bPoints_set, "*"},...
#              {vLine_set, "-g;RF Voltage;"}, "linecolor", "green");...
  ax = plotyy(tline, bline, tline, vlist);
  ylabel(ax(1), "BL value of BM [T m]");
  ylabel(ax(2), "RF Voltage [V]");
  ylim(ax(2), [0,500]);xlabel("Time [msec]");
  legend("BM Pattern", "RF Voltage");
endfunction
