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
## 2012-11-07
## * change a constant name to give physical_constant due to the specification change of physical_consntant.
##
## 2012-10-26
## * velocity argument can be an arrary
## 
## 2012-10-25
## * velocity can be an array.
##
## 2009-07-01
## * Use mass_energy.m
## * fix the result of helium is invalid.
## * helion's mass was used as helium mass i.e. the mass was 2/3.
##
## 2008-11-26
## * "helium" can be accept as a kind of partile.
##
## 2008-04-16
## * Use physical_constant instead of physicalConstant.
##
## 2007-10-24
## * renamed from momentumForVelocity

function result = momentum_with_velocity(velocity, particle) 
  if !nargin
    print_usage();
  endif
  
  #energy = 660 #[MeV]
  
  lv = physical_constant("speed of light in vacuum");
  b = velocity/lv;
  g = 1./sqrt(1-b.^2);
  
  mass_e = mass_energy(particle);  
  result = mass_e.*g.*b./lv;
endfunction
