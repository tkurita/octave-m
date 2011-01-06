## plot ...
## * synchrotron frequency and Phase angle of synchronus particle
## * bucket height, bucket Area in dE-phi coordinate
## * pattern of bending magnet and RF voltage
##
## parameters : 
## vlist: RF Voltage Pattern
## bline: pattern of bending magnet

function plotPhaseOsillation(tline,bline,bPoints_set,vlist,omega_s,phi_s,deltaEFromB,e_area, d_emax,nM,totalEnergy,phi1)
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
  deltaEFromB_set = [tline, deltaEFromB/1000]; #[msec; keV]
  d_emax_set = [tline, d_emax/1000]; #[msec; keV]
  e_area_set = [tline, e_area/10000]; #[msec; 10 keV]
  omega_s_set = [tline, omega_s./1000];
  # kEList = totalEnergy - nM*proton_eV; #Kinetic Energy
  kEList = totalEnergy - m0c2*1e6; #Kinetic Energy

  relative_e_area_set = [tline, (e_area./(kEList*4*pi)).*100]; #[msec; %]

  subplot(3,1,3);
  xyyplot({bline_set,"-;BM Pattern;", bPoints_set, "*"},...
          {vLine_set, "-;RF Voltage;"});
  subplot(3,1,2);
  xyplot(d_emax_set, "-;RF bucket height [KeV];",...
        e_area_set, "-;Bucket Area [10 KeV];")
  subplot(3,1,1);
  xyplot(omega_s_set, "-;synchrotorn Frequency [KHz];",...
        phi_s_set, "-;phase angle of synchronus particle [degree];");


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

  gplot bline_set title "BM Pattern",\
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
  
  gplot d_emax_set title "RF bucket height [KeV]",\
	  e_area_set title "Bucket Area [10 KeV]" #,\
								#deltaEFromB_set title "Energy gain/1 BClocl [KeV]",\
	  	  #relative_e_area_set axes x1y2 title "Relative Bucket Area [%]"

  ## thrid plot
  gset origin 0,0.66
  gset ylabel "synchrotorn Frequency [KHz]"
  gset y2label "phase angle [degree]"
  gplot omega_s_set title "synchrotorn Frequency [KHz]", \
	  phi_s_set axes x1y2 title "phase angle of synchronus particle [degree]"

  automatic_replot=1;
endfunction
