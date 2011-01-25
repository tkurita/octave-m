## usage : protonMeVtoBL(energy)
##
##=Parameters
## * energy -- 運動エネルギー [MeV]
##
##=Result
## Bρ [T * m]

function result = protonMeVtoBL(energy)
  result = protonMeVtoBrho(energy)*(pi/4);
endfunction
