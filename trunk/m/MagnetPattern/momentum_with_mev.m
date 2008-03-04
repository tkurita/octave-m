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
  #energy = 660 #[MeV]
    
#  switch particle
#    case "proton"
#      proton_MeV = physicalConstant("proton [MeV]");
#      massE = proton_MeV;
#    case "helium"
#      amu = physicalConstant("amu");
#      massE = amu *4;
#    case "carbon"
#      amu = physicalConstant("amu");
#      massE = amu *12;
#  endswitch
  mass_e = mass_energy(particle)
  lv = physical_constant("SPEED_OF_LIGHT_IN_VACUUM");
  W= energy + mass_e; #total energy [MeV]
  result = (1/lv)*sqrt(W^2 - mass_e^2);
endfunction
