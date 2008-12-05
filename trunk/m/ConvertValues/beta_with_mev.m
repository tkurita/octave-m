## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} beta_with_mev(@{mev}, @var{particle})
## @deftypefnx {Function File} {@var{result} =} beta_with_mev(@{mev}, @var{amu})
## 
## Return beta [velocity/c] of a paticle from its energy.
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
## * First implementation

function retval = beta_with_mev(varargin)
  mass_e = mass_energy(particle);
  result = c*sqrt(mev*(mev + 2*mass_e))/(mev+mass_e);
endfunction

%!test
%! beta_with_mev(10, "proton")
