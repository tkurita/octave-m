## usage : result = mass_energy(particle)
##  resolve rest mass enery [MeV]
##
##= Parameter
## * particle -- "proton" or "carbon"

function result = mass_energy(particle)
  switch particle
    case "proton"
      result = physicalConstant("proton [MeV]");
    case "helium"
      amu = physicalConstant("amu");
      result = amu *4;
    case "carbon"
      amu = physicalConstant("amu");
      result = amu *12;
  endswitch
endfunction