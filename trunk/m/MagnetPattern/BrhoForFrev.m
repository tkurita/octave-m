## usage : result = BrhoForFrev(f_rev, c_length, particle)
##  obsolete. use brho_with_frev
## =Parameters
## * f_rev -- revolution frequency [MHz]
## * c_length -- 周長 [m]
## * paticle -- "proton" or "carbon"
##
## =Result
## Bρ [T * m]

function result =  BrhoForFrev(f_rev, c_length, particle)
  #  energy = 660 #[MeV]
  #  charge = 6;
  #particle = "proton";
  #energy = 200;
  warning("BrhoForFrev is obsolete. Use brho_with_frev");
  switch particle
    case "proton"
      charge = 1;
    case "carbon"
      charge = 6;
    otherwise
      error("The kind of particle must be \"proton\" or \"carbon\". \"%s\" can not be accepted.", particle);
  endswitch
  
  p = momentumForFrev(f_rev, c_length, particle);
  result = p*1e6./charge;
endfunction
