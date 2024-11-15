## -*- texinfo -*-
## @deftypefn {Function File} {} momentum_with_frev(@var{frev} [MHz], @var{cicumference} [m], @var{particle} or @var{amu})
## @deftypefnx {Function File} {} momentum_with_frev(@var{lattice_rec}, @var{frev}, @var{particle} or @var{amu})
##
## Evaluate momentum [MeV/c] with revolution frequency @var{frev} [MHz] and @var{circumference} [m].
##
## If first argument is a structure @var{lattice_rec}, the circumfernece is calculated using lattice field of the structure.
##
## @var{particle} can be accept "proton", "helium", "carbon".
##
## @seealso{momentum_with_velocity}
##
## @end deftypefn

##== History
## 2009-05-28
## * if no arguments, print_usage().
##
## 2008-11-26
## * support "helium"
## 
## 2007-10-23
## * renamed from momentumForFrev

function result = momentum_with_frev(varargin)
  if (!nargin)
    print_usage();
    return;
  endif
  
  if (isstruct(varargin{1}))
    c_length = circumference(varargin{1});
    f_rev = varargin{2};
  else
    f_rev = varargin{1};
    c_length = varargin{2};
  endif
  
  #energy = 660 #[MeV]
  #f_rev = 11.9125
  #c_length = 33.2
  #particle = "carbon"
  velocity = c_length.*f_rev.*1e6;
  result = momentum_with_velocity(velocity, varargin{3});
endfunction
