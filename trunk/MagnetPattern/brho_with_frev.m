## -*- texinfo -*-
## @deftypefn {Function File} {@var{brho} [T*m] =} brho_with_frev(@var{frev}, @var{circumference} [m], @var{particle})
##
## @deftypefnx {Function File} {@var{brho} [T*m] =} brho_with_frev(@var{frev}, @var{circumference} [m], @var{amu}, @var{charge})
##
## @deftypefnx {Function File} {@var{lattice_rec} =} brho_with_frev(@var{lattice_rec}, @var{frev}, @var{particle})
##
## @deftypefnx {Function File} {@var{lattice_rec} =} brho_with_frev(@var{lattice_rec}, @var{frev}, @var{amu}, @var{charge})
##
## Evaluate B*rho value [T*m] with revolution frequency @var{frev} [MHz] and kind of particle.
##
## If first argument is a structure @var{lattice_rec}, the circumference is calculated using the lattice field of @var{lattice_rec}. And the B*rho value is set as a field 'brho' of the returnd strucutre.
##
## The kind of the particle can be specified with its name @var{paticle} or a set of @var{amu} and @var{charge}. @var{paricle} can be accept "proton" or "carbon".
##
## @seealso{momentum_with_frev}
##
## @end deftypefn

##== History
## 2007-10-23
## * renamed from BrhoForFrev

#function result =  BrhoForFrev(f_rev, c_length, particle)
function varargout = brho_with_frev(varargin)
  #  energy = 660 #[MeV]
  #  charge = 6;
  #particle = "proton";
  #energy = 200;
  
  if (ischar(varargin{3}))
    particle = varargin{3};
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
  
  p = momentum_with_frev(varargin{:});
  brho = p*1e6./charge;
  
  if (isstruct(varargin{1}))
    varargout{1} = setfields(varargin{1}, "brho", brho);
  else
    varargout{1} = brho;
  endif
  
endfunction
