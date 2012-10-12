## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} [m/s] =} velocity_with_brho(@var{brho}, @var{particle})
##
## @deftypefnx {Function File} {@var{result} [m/s] =} velocity_with_brho(@var{frev}, @var{amu}, @var{charge})
##
## @table @code
## @item @var{brho}
## [T*m]
## @item @var{particle}
## The kind of the particle. "proton", "helium", "carbon" or mass number.
##
## @item @var{charge}
## charge number.
## @end table
##
## @end deftypefn

##== History
## 2012-10-12
## * allow to omit charge parameter.
##
## 2009-06-25
## * First Implementation.

#function retval = velocity_with_brho(brho, particle, charge)
function retval = velocity_with_brho(varargin)
  if nargin < 2
    print_usage();
  endif
  brho = varargin{1};
  
  if (ischar(varargin{2}))
    particle = varargin{2};
    switch particle
      case "proton"
        charge = 1;
      case "helium"
        charge = 2;
      case "carbon"
        charge = 6;
      otherwise
        error("The kind of particle must be \"proton\", \"helium\" or \"carbon\". \"%s\" can not be accepted.", particle);
    endswitch
  else
    charge = varargin{3};
  endif
  
  mass_e = mass_energy(particle);
  p = charge.*brho.*1e-6; # [MeV/c]
  lv = physical_constant("SPEED_OF_LIGHT_IN_VACUUM");
  x = lv*p/mass_e; # beta/(sqrt(1-beta^2))
  b2 = x.^2./(1+x.^2);
  retval = sqrt(b2)*lv;
endfunction

%!test
%! velocity_with_brho(x)
