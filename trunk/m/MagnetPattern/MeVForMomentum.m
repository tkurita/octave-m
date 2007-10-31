## usage : result = MeVForMomentum(mevc, particle)
##  obtain kinetic enery from mementum [MeV/c]
##
##= Parameters
## * mevc -- momentum 
  
function result = MeVForMomentum(mevc, particle)
  mass_e = mass_energy(particle);
  c = physicalConstant("light velocity");
  result = sqrt(mass_e^2 + (p*c)^2) - mass_e;
endfunction