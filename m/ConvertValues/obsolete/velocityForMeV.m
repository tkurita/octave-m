## usage : result = velocityForMeV(mev, "particle")
##
## calculate velocity of a paticle from its energy.
##
##= Parameters
## * mev -- kinetic energy [MeV]
## * particle -- kind of a particle, "proton" or "carbon"
##
##= Results
## velocity [m/s]

##== History
## 2008-02-26
## * deprecated
## * Use physical_constant instead of physicalConstant

function result = velocityForMeV(mev, particle)
  warning("velocityForMeV is deprecated. Use velocity_with_mev");
  mass_e = mass_energy(particle);
  #c = physicalConstant("light velocity");
  c = physical_constant("SPEED_OF_LIGHT_IN_VACUUM");
  #result = c*sqrt(mev/(mev+mass_e));
  result = c*sqrt(mev*(mev + 2*mass_e))/(mev+mass_e);
endfunction

%!test
%! velocityForMeV(10,"proton")
