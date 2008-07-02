## -*- texinfo -*-
## @deftypefn {Function File} {@var{brho} [T*m] =} brho_with_velocity(@var{v}, @var{particle})
##
## @deftypefnx {Function File} {@var{brho} [T*m] =} brho_with_velocity(@var{v}, @var{amu}, @var{charge})
##
## Evaluate B*rho value [T*m] with velocity @var{v} [m/sec] and kind of particle.
##
## If first argument is a structure @var{lattice_rec}, the circumference is calculated using the lattice field of @var{lattice_rec}. And the B*rho value is set as a field 'brho' of the returnd strucutre.
##
## The kind of the particle can be specified with its name @var{paticle} or a set of @var{amu} and @var{charge}. @var{paricle} can be accept "proton" or "carbon".
##
## @seealso{momentum_with_frev}
##
## @end deftypefn

##== History
## 2008-06-22
## * first implementation

function varargout = brho_with_velocity(varargin)
  #  energy = 660 #[MeV]
  #  charge = 6;
  #particle = "proton";
  #energy = 200;
  
  if (ischar(varargin{2}))
    particle = varargin{2};
    switch particle
      case "proton"
        charge = 1;
      case "carbon"
        charge = 6;
      otherwise
        error("The kind of particle must be \"proton\" or \"carbon\". \"%s\" can not be accepted.", particle);
    endswitch
  else
    charge = varargin{4};
  endif  
  
  p = momentum_with_velocity(varargin{1:2});
  brho = p*1e6./charge;
  
  varargout{1} = brho;
endfunction
