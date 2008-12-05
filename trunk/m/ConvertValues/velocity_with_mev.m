## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} velocity_with_mev(@{mev}, @var{particle})
## @deftypefnx {Function File} {@var{result} =} velocity_with_mev(@{mev}, @var{amu})
## 
## Return velocity [m/s] of a paticle from its energy.
##
## @table @code
## @item @var{mev}
## Kinetic Energy in MeV
## @item @var{particle}
## name of particle, "proton", "helium" or "carbon"
## @item @var{amu}
## Mass number
## @end table
##
## @seealso{mass_energy}
## @end deftypefn

##== History
## 2008-12-05
## * Help comment is rewritten as texinfo format.
##
## 2008-02-26
## * rename velocityForMeV to velocity_with_mev
## * Use physical_constant instead of physicalConstant

function result = velocity_with_mev(mev, particle)
  mass_e = mass_energy(particle);
  c = physical_constant("SPEED_OF_LIGHT_IN_VACUUM");
  result = c*sqrt(mev*(mev + 2*mass_e))/(mev+mass_e);
endfunction

%!test
%! velocity_with_mev(10,"proton")
