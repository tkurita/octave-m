## -*- texinfo -*-
## @deftypefn {Function File} {@var{brho} [T*m] =} brho_with_mev(@var{k}, @var{particle})
##
## @deftypefnx {Function File} {@var{brho} [T*m] =} brho_with_mev(@var{k}, @var{amu}, @var{charge})
##
## Evaluate B*rho value [T*m] with kinetic energy @var{k} [MeV] and kind of particle.
##
## The kind of the particle can be specified with its name @var{paticle} or a set of @var{amu} and @var{charge}. @var{paricle} can be accept "proton", "helium" or "carbon".
##
## @seealso{momentum_with_frev}
##
## @end deftypefn

##== History
## 2009-05-22
## * When no arguments, execute print_usage().
## 
## 2008-12-05
## * Fix erro when charge parameter is passed.
##
## 2008-08-01
## * first implementation

function varargout = brho_with_mev(varargin)
  if (nargin == 0)
    print_usage();
  endif
  
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
  
  p = momentum_with_mev(varargin{1:2});
  brho = p*1e6./charge;
  
  varargout{1} = brho;
endfunction
