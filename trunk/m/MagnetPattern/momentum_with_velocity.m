## -*- texinfo -*-
## @deftypefn {Function File} momentum_with_velocity(@var{velocity}, @var{amu})
## @deftypefnx {Function File} momentum_with_velocity(@var{velocity}, @var{particle})
##
## Return momentum [MeV/c] calculated with @var{velocity} [m/s] and mass number @var{amu}.
##
## @var{particle} can be accept a kind of particle "proton" or "carbon"
##
## @seealso{momentum_with_frev}
##
## @end deftypefn

##== History
## renamed from momentumForVelocity

function result = momentum_with_velocity(velocity, particle)  
  #energy = 660 #[MeV]
  
  lv = physicalConstant("light velocity");
  b = velocity/lv;
  g = 1/sqrt(1-b^2);
  
  if (ischar(particle))
    switch particle
      case "proton"
        massE = physicalConstant("proton [MeV]");
      case "carbon"
        amu = physicalConstant("amu");
        massE = amu *12;
    endswitch
  else
    if (particle > 1)
        amu = physicalConstant("amu");
        massE = amu *12;
    elseif (particle == 1)
      massE = physicalConstant("proton [MeV]");
    else
      error("a.m.u. must be greater than 1.");
    endif
  endif
  
  result = massE*g*b/lv;
endfunction
