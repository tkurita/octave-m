## plot ...
## synchrotron frequency and Phase angle of synchronus particle
## bucket area in dR/(h omega)-phi coordinate
## pattern of bending magnet and RF voltage

function plotPhaseOsillation2(tLine,bLine,bPoints_set,vList,omega_s,phi_s,eArea2)

  global lv; # light velocity
  global proton_ev; 

  bLine_set = [tLine;bLine]';
  vLine_set = [tLine;vList]';
  phi_s_set = [tLine;phi_s .*360./(2*pi)]';
  eArea2_set = [tLine; eArea2]'; #[msec; 10 eV sec]
  omega_s_set = [tLine;omega_s./1000]';

  automatic_replot=0;
  gset nomultiplot
  ##common seetting
  gset size 0.8,0.5
  gset rmargin 10
  gset lmargin 10
  gset y2tics
  gset ytics nomirror

  gset multiplot
  ##fist plot: BM Pattern and RF Voltage pattern
  gset origin 0,0
  gset bmargin
  gset xtics
  gset format x "%g"
  gset xlabel "Time [msec]"
  gset ylabel 1,0
  gset ylabel "BL value of BM [T*m]"
  gset y2label "RF Voltage [V]"
  gset y2range [0:450]
  gplot bLine_set title "BM Pattern",\
	  bPoints_set with points title "",\
	  vLine_set axes x1y2 title "RF Voltage"

  ## common settings for second plot
  gset noxlabel
  gset bmargin 0
  gset y2range [*:*]
  gset format x ""
  
  ## second plot
  gset origin 0,0.5
  gset ylabel "synchrotorn Frequency [KHz]\\nphase angle [degree]"
  gset y2label "RF bucket area [eV*sec]"
  gplot omega_s_set title "synchrotorn Frequency [KHz]", \
	  phi_s_set title "phase angle of synchronus particle [degree]",\
	  eArea2_set axes x1y2 title "bucket Area"

endfunction
