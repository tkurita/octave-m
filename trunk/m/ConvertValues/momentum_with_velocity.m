## -*- texinfo -*-
## @deftypefn {Function File} momentum_with_velocity(@var{velocity}, @var{amu})
## @deftypefnx {Function File} momentum_with_velocity(@var{velocity}, @var{particle})
##
## Return momentum [MeV/c] calculated with @var{velocity} [m/s] and mass number @var{amu}.
##
## @var{particle} can be accept a kind of particle "proton", "carbon" or "helium"
##
## @seealso{momentum_with_frev}
##
## @end deftypefn

##== History
## 2008-11-26
## * "helium" can be accept as a kind of partile.
##
## 2008-04-16
## * Use physical_constant instead of physicalConstant.
##
## 2007-10-24
## * renamed from momentumForVelocity

function result = momentum_with_velocity(velocity, particle)  
  #energy = 660 #[MeV]
  
  lv = physical_constant("SPEED_OF_LIGHT_IN_VACUUM");
  b = velocity/lv;
  g = 1/sqrt(1-b^2);
  
  if (ischar(particle))
    switch particle
      case "proton"
        massE = physical_constant("PROTON_MASS_ENERGY_EQUIVALENT_IN_MEV");
      case "helium"
        massE = physical_constant("HELION_MASS_ENERGY_EQUIVALENT_IN_MEV");
      case "carbon"
        amu = physical_constant("ATOMIC_MASS_CONSTANT_ENERGY_EQUIVALENT_IN_MEV");
        massE = amu *12;
    endswitch
  else
    if (particle == 1)
      massE = physical_constant("PROTON_MASS_ENERGY_EQUIVALENT_IN_MEV");
    elseif (particle == 4)
      massE = physical_constant("HELION_MASS_ENERGY_EQUIVALENT_IN_MEV");
    elseif (particle > 1)
      amu = physical_constant("ATOMIC_MASS_CONSTANT_ENERGY_EQUIVALENT_IN_MEV");
      massE = amu *12;
    else
      error("a.m.u. must be greater than 1.");
    endif
  endif
  
  result = massE*g*b/lv;
endfunction
