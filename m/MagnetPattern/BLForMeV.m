## usage : BLForMeV(energy, particle)
##
##= Parameters
## * energy -- Kinetic Energy [MeV]
## * paticle -- "proton" or "carbon"
## * angle -- [rad]
##
##= Result
## Bρ [T * m]

function result = BLForMeV(energy, particle, angle)
  brho = BrhoForMeV(energy, particle);
  result = brho*angle;
endfunction
