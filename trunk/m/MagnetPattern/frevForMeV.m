## usage : result = frevForMeV(mev, circumstance, particle)
##  calculate revolution frequency of a particle from its energy
##
##= Parameters
## * mev -- kinetic energy [MeV]
## * circumstance -- circumstance of a ring [m]
## * particle -- kind of a particle, should be "proton" or "carbon"
##
##= Result
## revolution frequency [Hz]

function result = frevForMeV(mev, circumstance, particle)
  v = velocityForMeV(mev, particle);
  result = v/circumstance;
endfunction

%!test
%! frevForMeV(10, 33.201, "proton")