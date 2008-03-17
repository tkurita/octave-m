## usage : eVtoMomentum(energy, amu)
##
##=Parameters
## * energy -- 運動エネルギー [eV]
## * emu -- 質量数 [a.m.u]
##=Result
## 運動量 [eV/c]
function result = eVtoMomentum(energy, amu)
  #energy = 660 #[MeV]
  global proton_eV;
  global lv;
  mass = amu * proton_eV;
  W = energy + mass; #total energy [MeV]
  result = (1/lv)*sqrt(W^2 - mass^2);
endfunction
