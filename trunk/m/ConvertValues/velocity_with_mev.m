## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} velocity_with_mev(@var{mev}, @var{particle})
## @deftypefnx {Function File} {@var{result} =} velocity_with_mev(@var{mev}, @var{amu})
## 
## Return velocity [m/s] of a paticle from its energy.
## 
## @table @var
## @item mev
## Kinetic Energy in MeV
## @item particle
## name of particle, "proton", "helium" or "carbon"
## @item amu
## Mass number
## @end table
##
## @seealso{mass_energy}
## @end deftypefn

##== History
## 2013-03-25
## * support new physical_constants
##
## 2011-01-26
## * @var{mev} can be matrix.
##
## 2008-12-05
## * Help comment is rewritten as texinfo format.
##
## 2008-02-26
## * rename velocityForMeV to velocity_with_mev
## * Use physical_constant instead of physicalConstant

function result = velocity_with_mev(mev, particle)
  if !nargin
    print_usage();
    return;
  endif
  mass_e = mass_energy(particle);
  c = physical_constant("speed of light in vacuum");
  result = c*sqrt(mev.*(mev + 2*mass_e))./(mev+mass_e);
endfunction

%!test
%! velocity_with_mev(10,"proton")
