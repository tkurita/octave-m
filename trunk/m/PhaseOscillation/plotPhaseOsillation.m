## plot ...
## * synchrotron frequency and Phase angle of synchronus particle
## * bucket height, bucket Area in dE-phi coordinate
## * pattern of bending magnet and RF voltage
##
## parameters : 
## vList: RF Voltage Pattern
## bLine: pattern of bending magnet

function plotPhaseOsillation(tLine,bLine,bPoints_set,vList,omega_s,phi_s,deltaEFromB,eArea, deltaEmax,nM,totalEnergy,phi1)

  global lv; # light velocity
  global proton_eV; 

  bLine_set = [tLine;bLine]';
  vLine_set = [tLine;vList]';
  phi_s_set = [tLine;phi_s .*360./(2*pi)]';
  deltaEFromB_set = [tLine; deltaEFromB/1000]'; #[msec; keV]
  deltaEmax_set = [tLine; deltaEmax/1000]'; #[msec; keV]
  eArea_set = [tLine; eArea/10000]'; #[msec; 10 keV]
  omega_s_set = [tLine;omega_s./1000]';
  kEList = totalEnergy - nM*proton_eV; #Kinetic Energy

  relative_eArea_set = [tLine; (eArea./(kEList*4*pi)).*100]'; #[msec; %]

  automatic_replot=0;
  gset nomultiplot
  #oneplot()

  ##common seetting
  gset size 0.8,0.33
  gset rmargin 10
  gset lmargin 10
  gset y2tics
  gset ytics nomirror
  
  
  gset multiplot
  #multiplot(1,3)
  ##fist plot: BM Pattern and RF Voltage pattern
  gset origin 0,0
  gset bmargin
  gset xtics
  gset format x "%g"
  xlabel("Time [msec]")
  gset ylabel 1,0
  ylabel("BL value of BM [T m]")
  y2label("RF Voltage [V]")
  y2range(0,700)

  gplot bLine_set title "BM Pattern",\
 	  bPoints_set with points title "",\
 	  vLine_set axes x1y2 title "RF Voltage"

  ## common settings for second plot
  gset noxlabel
  xlabel("")
  gset bmargin 0
  gset noxlabel
  gset format x ""
  gset y2range [*:*]
  y2range();

  ## second plot: RF bucket height and energy gain
  gset origin 0,0.33
  gset ylabel "Bucket Height [KeV]\\nBucket Area [10KeV]"
  #ylabel("Bucket Height [KeV]\\nBucket Area [10KeV]");
#  y2label("Relative Bucket Area [%]")
  y2label("")
  
  gplot deltaEmax_set title "RF bucket height [KeV]",\
	  eArea_set title "Bucket Area [10 KeV]" #,\
								#deltaEFromB_set title "Energy gain/1 BClocl [KeV]",\
	  	  #relative_eArea_set axes x1y2 title "Relative Bucket Area [%]"

  ## thrid plot
  gset origin 0,0.66
  gset ylabel "synchrotorn Frequency [KHz]"
  gset y2label "phase angle [degree]"
  gplot omega_s_set title "synchrotorn Frequency [KHz]", \
	  phi_s_set axes x1y2 title "phase angle of synchronus particle [degree]"

  automatic_replot=1;
endfunction
