## usage : protonMeVtoMomentum(energy)
##
##=Parameters
## * energy -- 運動エネルギー [eV]
##=Result
## 運動量 [MeV/c]

function result = protonMeVtoMomentum(energy)
  #energy = 660 #[MeV]
  global proton_MeV;
  global lv;
  global proton_Kg;
  global eC;
  global amu;
  mass = proton_MeV;
  #mass = 938;
  #mass = (proton_Kg*lv^2)/eC/1e6;
  #mass = amu;
  W = energy + mass; #total energy [MeV]
  result = (1/lv)*sqrt(W^2 - mass^2);
endfunction
