## usage : deltaE = deltaEwithBstep(bLine,deltaB,nM)
## bLine : 磁場パターン
## deltaB : 1 B clock に相当する磁場の変化量。変更磁場量。[gauss m]
## nM : 質量数 [a.m.u]

function deltaE = deltaEwithBstep(bLine,deltaB,nM)
  global lv; # light velocity [m/sec]
  global proton_eV;
  m0c2 = nM * proton_eV;
  EeDeltaE = sqrt(m0c2^2 + ((bLine.+(deltaB*1e-5))./(pi/4)).^2 *lv^2);
  Ee = BFieldtoEnergy(bLine,nM);
  deltaE = EeDeltaE - Ee;
endfunction

function totalEnergy = BFieldtoEnergy(bLine,nM);
  global lv;
  global proton_eV;
  m0c2 = nM * proton_eV; #[eV]
  Ee2 = m0c2^2 + (bLine./(pi/4)).^2 .*lv^2; #[ev2]
  totalEnergy = sqrt(Ee2); #[eV]
endfunction
