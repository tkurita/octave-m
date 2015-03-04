## -*- texinfo -*-
## @deftypefn {Function File} {} mev_with_brho(@var{brho}, @var{particle}, @var{charge})
##
## Evaluate Kinetic energy from Brho and chanrge number.
##
## @table @code
## @item @var{brho}
## B*rho [T*m]
##
## @item @var{particle}
## The kind of the particle. "proton", "helium", "carbon" or mass number.
##
## @item @var{charge}
## charge number
##
## @end table
## @end deftypefn

##== History
## 2009-06-10
## * change order of arguments.
##
## 2008-03-17
## * first implementaion

function result = mev_with_brho(brho, particle, charge)
  if nargin < 3
    print_usage();
  endif
  result = mev_with_momentum(charge.*brho.*1e-6, particle);
endfunction