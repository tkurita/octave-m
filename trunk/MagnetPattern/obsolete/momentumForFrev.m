## usage : momentumForFrev(f_rev, c_length, particle)
##  obsolete. use momentum_with_frev
##
##=Parameters
## * f_rev -- revolution frequency [MHz]
## * c_length -- contour 周長 [m]
## * particle -- "proton" or "carbon"
##
##=Result
## 運動量 [MeV/c]

function result = momentumForFrev(f_rev, c_length, particle)
  warning("momentumForFrev is obsolete. Use momentun_with_frev");
  #energy = 660 #[MeV]
  #f_rev = 1.316875
  #c_length = 33.02
  #particle = "proton"
  velocity = c_length*f_rev*1e6;
  result = momentumForVelocity(velocity, particle);
endfunction
