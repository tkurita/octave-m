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

function result = velocityForMeV(mev, particle)
  mass_e = mass_energy(particle);
  c = physicalConstant("light velocity");
  #result = c*sqrt(mev/(mev+mass_e));
  result = c*sqrt(mev*(mev + 2*mass_e))/(mev+mass_e);
endfunction

%!test
%! velocityForMeV(10,"proton")