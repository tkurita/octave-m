## usage : protonMeVtoBrho(energy)
##
##=Parameters
## * energy -- 運動エネルギー [MeV]

##=Result
## Bρ [T * m]

function result = protonMeVtoBrho(energy)
#  energy = 660 #[MeV]
#  charge = 6;
  p = protonMeVtoMomentum(energy);
  result = p*1e6;
endfunction
