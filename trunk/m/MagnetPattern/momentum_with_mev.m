## usage : momentum_with_mev(energy, particle)
##
##= Parameters
## * energy -- 運動エネルギー [MeV]
## * particle -- "proton" or "carbon"
##
##= Result
## 運動量 [MeV/c]

##== History
## * renamed from momentumForMeV

function result = momentum_with_mev(energy, particle)
  mass_e = mass_energy(particle);
  lv = physical_constant("SPEED_OF_LIGHT_IN_VACUUM");
  W= energy + mass_e; #total energy [MeV]
  result = (1/lv).*sqrt(W.^2 - mass_e.^2);
endfunction
