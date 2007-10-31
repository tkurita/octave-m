## usage : energyToMomentum(energy)
##
##=Parameters
## * energy -- 運動エネルギー [MeV]
##
##=Result
## 運動量 [MeV/c]
function result = energyToMomentum(energy)
  #energy = 660 #[MeV]
  global proton_eV;
  global lv;
  proton_MeV = proton_eV*1e-6;
  W= energy + proton_MeV; #total energy [MeV]
  result = (1/lv)*sqrt(W^2 - proton_MeV^2);
endfunction
