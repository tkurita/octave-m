## usage : result = mass_energy(particle)
##  resolve rest mass enery [MeV]
##
##== Parameter
## * particle -- "proton" or "carbon" or "helium" or mass number [amu]

##== History
## 2008-02-26
## * Use physical_constant intead of physicalConstant.
## * mass_energy can accelpt mass number

function result = mass_energy(particle)
  if (isnumeric(particle))
    amu = physical_constant("ATOMIC_MASS_CONSTANT_ENERGY_EQUIVALENT_IN_MEV");
    result = amu * particle;
  else
    switch particle
      case "proton"
        result = physical_constant("PROTON_MASS_ENERGY_EQUIVALENT_IN_MEV");
      case "helium"
         result = physical_constant("ALPHA_PARTICLE_MASS_ENERGY_EQUIVALENT_IN_MEV");
      case "carbon"
        amu = physical_constant("ATOMIC_MASS_CONSTANT_ENERGY_EQUIVALENT_IN_MEV");
        result = amu *12;
      otherwise
        error("\"%s\" is unknown particle specifier.", particle);
    endswitch
  endif
   
endfunction