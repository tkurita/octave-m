## usage : energyToBL(energy, charge)
##
##=Parameters
## * energy -- 運動エネルギー [MeV]
## * charge -- イオンの価数
##
##=Result
## Bρ [T * m]

function result = energyToBL(energy, charge)
  energy = 660 #[MeV]
  charge = 6;
  p = energyToMomentum(energy)
  result = p * 1e6 /charge;
endfunction
