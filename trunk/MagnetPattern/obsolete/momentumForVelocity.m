## usage : momentumForVelocity(velocity, particle)
##  obsolete. use momentum_with_velocity
##
##= Parameters
## * f_rev -- revolution frequency [MHz]
## * particle -- "proton" or "carbon"
##
##= Result
## 運動量 [MeV/c]

function result = momentumForVelocity(velocity, particle)
  #energy = 660 #[MeV]
  warning("momentumForVelocity is obsolete. use momentum_with_velocity.");
  lv = physicalConstant("light velocity");
  b = velocity/lv;
  g = 1/sqrt(1-b^2);
  
  switch particle
    case "proton"
      massE = physicalConstant("proton [MeV]");
    case "carbon"
      amu = physicalConstant("amu");
      massE = amu *12;
  endswitch
  result = massE*g*b/lv;
endfunction
