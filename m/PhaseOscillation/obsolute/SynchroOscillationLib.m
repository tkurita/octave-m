1; #script file
#BM pattern of H+ 10MeV -> 200MeV
#bPattern=[0,35,60,85,599.2,624.2,649.2;
#	0.3662,0.3662,0.3761,0.4256,1.6473,1.6968,1.7067];

PhysicalParameters

function defineBasicParameters()
  global C; # シンクロトロンの周長 [m]
#  global lv; # 光速度 [m/sec]
#  global protonME; # proton の静止質量エネルギー
  C = 33.201; #周長 [m]
#  lv = 2.99792458*10^8; #[m/s] light velocity
#  protonME = 938 * 10^6; #[eV]
endfunction

function [omega_s,Ee,eta] = synchroFrequency(alpha, nM, bLine, h, sinPhi_s, vList,C)
  ## function file として独立させた obsolute
  ## シンクロトロン周波数を計算
  ## alpha : momentum compaction factor;
  ## nM: mass number 
  ## bLine : 磁場パターン
  ## h : harmonic number
  ## sihPhi_s : sin(phi_s) 
  ## phi_s : synchronus particle の RF phase angle
  ## vList : 電圧パターン
  ## omega_s : シンクロトロン周波数[rad/sec]
  ## Ee : 磁場に対応する全エネルギー
  ## eta : alpha - 1/gamma^2 
  ## C : シンクロトロンの周長 [m]
								#global C; # シンクロトロンの周長 [m]
  global lv;
  global proton_ev;
  m0c2 = nM * proton_ev; #[eV]
  Ee2 = m0c2^2 + (bLine./(pi/4)).^2 .*lv^2; #[ev2]
  Ee = sqrt(Ee2); #[eV]
  eta = alpha - m0c2^2./Ee2; #
  cosphi = - sqrt(1 - sinPhi_s.^2);
  omegaC = 2 * pi*lv/C;
  omega_s = sqrt((eta .* h .* omegaC^2 .*vList .* cosphi)./(2 * pi .* Ee));
endfunction

function [phi_s,sinPhi_s] = shnchronusRFPhase(bLine,tLine,vList,C)
  ## 独立させた obsolute
  ## synchronus particle の加速位相を計算
  ## transition 前後、RFの位相と時間軸の関係等を無視して、0 - pi/2 の範囲で計算する。
  ## bGrad : 磁場の変化率
  ## vList : 電圧パターン
  ## C : 周長 [m] WERC は 33.201mm
  #global C;
  
  bGrad=gradient(bLine,tLine/1000); #time difference of BM magnetic field
  sinPhi_s = (C*bGrad/(pi/4))./vList;
  if ( isnan(sinPhi_s(1)) )
	sinPhi_s(1) = 0;
  endif
  phi_s =asin(sinPhi_s);
endfunction

function totalEnergy = BFieldtoEnergy(bLine,nM);
  global lv;
  global proton_ev;
  m0c2 = nM * proton_ev; #[eV]
  Ee2 = m0c2^2 + (bLine./(pi/4)).^2 .*lv^2; #[ev2]
  totalEnergy = sqrt(Ee2); #[eV]
endfunction

function deltaE = deltaEwithBstep(bLine,deltaB,nM)
  ## bLine : 磁場パターン
  ## deltaB : 1 B clock に相当する磁場の変化量。変更磁場量。[gauss m]
  ## nM : 質量数 [a.m.u]
  global lv; # light velocity [m/sec]
  global proton_ev;
  m0c2 = nM * proton_ev;
  EeDeltaE = sqrt(m0c2^2 + ((bLine.+(deltaB*1e-5))./(pi/4)).^2 *lv^2)
  Ee = BFieldtoEnergy(bLine,nM);
  deltaE = EeDeltaE - Ee;
endfunction

function deltaEmax = RFBucketHeight(vList,nM,Ee, eta, h, phi_s)
  ## synchronus particle の位相が phi_s の時の RF Bucket Height を計算する。
  ## 単位は、[eV]
  ## BucketSizeLib が必要
  global proton_ev;
  y = maxHalfHeight(phi_s);
  m0c2 = nM*proton_ev;
  beta2 = 1 - (m0c2^2)./(Ee.^2);
  deltaEmax = sqrt(vList .* beta2./h) .* y .*sqrt(abs(Ee./(pi.*eta)));
endfunction

function [eArea,eArea2,deltaEmax,phi1] = RFbucketEArea(vList, nM, Ee, eta, h, phi_s)
  ## parameters : 
  ## vList : RF Voltage Pattern, must be (voltage * charge state)
  ## phi_s : phase angle of synchronus particle
  ## Ee : Total energy
  ## nM : mass number of the particle
  ## 
  ## results : 
  ## eArea : RF Bucket Area in deltaE-phi coordinate [eV]
  ## eArea2 : RF Bucket Area in deltaE/(h omega_rev) -phi coordinate [ev sec]
  ## deltaEmax : bucket height [eV]
  ## phi1 : unstable fixed point
  global proton_ev;
  global lv;
  global C;
  for n = 1:length(phi_s)
	fs = phi_s(n);
	[alphaArea(n),yHeight(n), phi1(n)] = calcBucketSize(fs);
  endfor
  m0c2 = nM*proton_ev;
  beta2 = 1 - (m0c2^2)./(Ee.^2);
  eArea = 16.*sqrt(vList .* beta2 .*Ee./(2*pi*h.*abs(eta))).*alphaArea;
##  omega_rev = 2*pi.*sqrt(beta2).*lv./C;
##  eArea2 = eArea./(h .*omega_rev); 
  eArea2 = 16.*(C/lv) .* sqrt(vList .* Ee./((2*pi*h)^3.*abs(eta))).*alphaArea;
  deltaEmax = sqrt(vList .* beta2./h) .* yHeight .*sqrt(abs(Ee./(pi.*eta)));
endfunction

function plotPhaseOsillation(tLine,bLine,bPoints_set,vList,omega_s,phi_s,deltaEFromB,eArea, deltaEmax,nM,totalEnergy,phi1)
  ## plot ...
  ## * synchrotron frequency and Phase angle of synchronus particle
  ## * bucket height, bucket Area in dE-phi coordinate
  ## * pattern of bending magnet and RF voltage
  ##
  ## parameters : 
  ## vList: RF Voltage Pattern
  ## bLine: pattern of bending magnet

  global lv; # light velocity
  global proton_ev; 

  bLine_set = [tLine;bLine]';
  vLine_set = [tLine;vList]';
  phi_s_set = [tLine;phi_s .*360./(2*pi)]';
  deltaEFromB_set = [tLine; deltaEFromB/1000]'; #[msec; keV]
  deltaEmax_set = [tLine; deltaEmax/1000]'; #[msec; keV]
  eArea_set = [tLine; eArea/10000]'; #[msec; 10 keV]
  omega_s_set = [tLine;omega_s./1000]';
  kEList = totalEnergy - nM*proton_ev; #Kinetic Energy

  relative_eArea_set = [tLine; (eArea./(kEList*4*pi)).*100]'; #[msec; %]

  #automatic_replot=0;
  #gset nomultiplot
  ##common seetting
  #gset size 0.8,0.33
  #gset rmargin 10
  #gset lmargin 10
  #gset y2tics
  #gset ytics nomirror
  
  
  #gset multiplot
  oneplot()
  multiplot(1,3)
  ##fist plot: BM Pattern and RF Voltage pattern
  #gset origin 0,0
  #gset bmargin
  #gset xtics
  gset format x "%g"
  xlabel("Time [msec]")
  #gset ylabel 1,0
  ylabel("BL value of BM [T m]")
  y2label("RF Voltage [V]")
  y2range(0,450)
#   mplot(tLine,bLine,";BM Pattern;",
# 		tLine,vList,"RF Voltage")

  gplot bLine_set title "BM Pattern",\
 	  bPoints_set with points title "",\
 	  vLine_set axes x1y2 title "RF Voltage"

  ## common settings for second plot
  #gset noxlabel
  xlabel()
  #gset bmargin 0
  #gset noxlabel
  #gset format x ""
  #gset y2range [*:*]
  y2range();

  ## second plot: RF bucket height and energy gain
  #gset origin 0,0.33
  #gset ylabel "Bucket Height [KeV]\\nBucket Area [10KeV]"
  ylabel("Bucket Height [KeV]\\nBucket Area [10KeV]");
  #gset y2label "Relative Bucket Area [%]"
  y2label("Relative Bucket Area [%]")
  
  gplot deltaEmax_set title "RF bucket height [KeV]",\
	  deltaEFromB_set title "Energy gain/1 BClocl [KeV]",\
	  eArea_set title "Bucket Area [10 KeV]",\
	  relative_eArea_set axes x1y2 title "Relative Bucket Area [%]"

  ## thrid plot
  gset origin 0,0.66
  gset ylabel "synchrotorn Frequency [KHz]"
  gset y2label "phase angle [degree]"
  gplot omega_s_set title "synchrotorn Frequency [KHz]", \
	  phi_s_set axes x1y2 title "phase angle of synchronus particle [degree]"

endfunction

function plotPhaseOsillation2(tLine,bLine,bPoints_set,vList,omega_s,phi_s,eArea2)
  ## plot ...
  ## synchrotron frequency and Phase angle of synchronus particle
  ## bucket area in dR/(h omega)-phi coordinate
  ## pattern of bending magnet and RF voltage

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

#LOADPATH=['./libs:~/share/octave:' DEFAULT_LOADPATH];

#BucketSizeLib
