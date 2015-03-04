## usage : deltaE = dE_with_dB(bLine,deltaB,nM)
## bLine : 磁場パターン
## deltaB : 1 B clock に相当する磁場の変化量。変更磁場量。[gauss m]
## nM : 質量数 [a.m.u]

##== History
## 2014-04-11
## * support new physical_constant.
## 2011-01-05
## * renamed from deltaEwithBstep

function deltaE = dE_with_dB(bLine,deltaB,nM)
  lv = physical_constant("speed of light in vacuum") ; # light velocity [m/sec]
  #m0c2 = nM * proton_eV;
  m0c2 = mass_energy(nM)*1e6;
  EeDeltaE = sqrt(m0c2^2 + ((bLine.+(deltaB*1e-5))./(pi/4)).^2 *lv^2);
  Ee = BFieldtoEnergy(bLine, m0c2, lv);
  deltaE = EeDeltaE - Ee;
endfunction

function totalEnergy = BFieldtoEnergy(bLine, m0c2, lv);
#  global lv;
#  global proton_eV;
#  m0c2 = nM * proton_eV; #[eV]
  Ee2 = m0c2^2 + (bLine./(pi/4)).^2 .*lv^2; #[ev2]
  totalEnergy = sqrt(Ee2); #[eV]
endfunction
