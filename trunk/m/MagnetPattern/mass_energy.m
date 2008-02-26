## usage : result = mass_energy(particle)
##  resolve rest mass enery [MeV]
##
##== Parameter
## * particle -- "proton" or "carbon" or "helium" or mass number [amu]

##== History
## 
function result = mass_energy(particle)
  switch particle
    case "proton"
      result = physical_constant("PROTON_MASS_ENERGY_EQUIVALENT_IN_MEV");
    case "helium"
       result = physical_constant("ALPHA_PARTICLE_MASS_ENERGY_EQUIVALENT_IN_MEV");
    case "carbon"
      amu = physical_constant("ATOMIC_MASS_CONSTANT_ENERGY_EQUIVALENT_IN_MEV");
      result = amu *12;
    otherwise

  endswitch
endfunction