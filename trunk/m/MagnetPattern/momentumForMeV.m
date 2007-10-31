## usage : momentumForMeV(energy, particle)
##
##= Parameters
## * energy -- 運動エネルギー [MeV]
## * particle -- "proton" or "carbon"
##
##= Result
## 運動量 [MeV/c]

function result = momentumForMeV(energy, particle)
  #energy = 660 #[MeV]
    
  switch particle
    case "proton"
      proton_MeV = physicalConstant("proton [MeV]");
      massE = proton_MeV;
    case "carbon"
      amu = physicalConstant("amu");
      massE = amu *12;
  endswitch
  
  lv = physicalConstant("light velocity");
  W= energy + massE; #total energy [MeV]
  result = (1/lv)*sqrt(W^2 - massE^2);
endfunction
