## -*- texinfo -*-
## @deftypefn {Function File} {@var{brho} [T*m] =} brho_with_frev(@var{frev} [MHz], @var{circumference} [m], @var{particle} or @var{charge})
##
## @deftypefnx {Function File} {@var{lattice_rec} =} brho_with_frev(@var{lattice_rec}, @var{frev} [MHz], @var{particle} or @var{charge})
##
## Return B*rho value [T*m] with revolution frequency @var{frev} [MHz] and kind of particle.
##
## If first argument is a structure @var{lattice_rec}, the circumference is calculated using the lattice field of @var{lattice_rec}. And the B*rho value is set as a field 'bhro' of returnd strucutre.
##
## The last argument is a a kind of particle @var{particle} or a charge @var{charge}.
##
## @var{particle} must be "proton" of "carbon".
##
## @end deftypefn


## usage : result = BrhoForFrev(f_rev, c_length, particle)
##
## =Parameters
## * f_rev -- revolution frequency [MHz]
## * c_length -- 周長 [m]
## * paticle -- "proton" or "carbon"
##
## =Result
## Bρ [T * m]
## 

##== History
## 2007-10-23
## * renamed from BrhoForFrev

#function result =  BrhoForFrev(f_rev, c_length, particle)
function varargout = brho_with_frev(varargin)
  #  energy = 660 #[MeV]
  #  charge = 6;
  #particle = "proton";
  #energy = 200;
  
  if (isstruct(varargin{1}))
    lattice_rec = varargin{1};
    c_length = circumference(lattice_rec);
    f_rev = varargin{2};
  else
    f_rev = varargin{1};
    c_length = varargin{2};
  endif
  
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
    charge = varargin{3};
  endif  
  
  p = momentumForFrev(f_rev, c_length, particle);
  result = p*1e6./charge;
endfunction
