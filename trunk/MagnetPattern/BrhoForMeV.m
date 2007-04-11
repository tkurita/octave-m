## usage : BrhoForMeV(energy, particle)
##
##=Parameters
## * energy -- 運動エネルギー [MeV]
## * paticle -- "proton" or "carbon"
##=Result
## Bρ [T * m]

function result =  BrhoForMeV(energy, particle)
  #  energy = 660 #[MeV]
  #  charge = 6;
  #particle = "proton";
  #energy = 200;
  
  switch particle
    case "proton"
      charge = 1;
    case "carbon"
      charge = 6;
    otherwise
      error("The kind of particle must be \"proton\" or \"carbon\". \"%s\" can not be accepted.", particle);
  endswitch
  
  p = momentumForMeV(energy, particle);
  result = p*1e6./charge;
endfunction
