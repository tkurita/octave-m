## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} mevalue_with_brho(@var{brho})
##
## Convert Brho [T*m] to ME value (E*A/Z^2) [MeV*a.m.u] 
##
## (ME value)*(Z^2/A) give the evergy which the magnet can bend.
##
## @table @code
## @item @var{brho}
## [T*m]
## @end table
##
## @end deftypefn

##== History
## 2008-12-08
## * First implementation

function retval = mevalue_with_brho(varargin)
  brho = varargin{1};
  m0 = physical_constant("ATOMIC_MASS_CONSTANT");
  e0 = physical_constant("ELEMENTARY_CHARGE");
  a = 1000*sqrt(2*m0/e0);
  retval = (brho/a)^2
endfunction

%!test
%! mevalue_with_brho(0.625) #ans = 18.845
