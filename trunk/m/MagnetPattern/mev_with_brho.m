## -*- texinfo -*-
## @deftypefn {Function File} {} mev_with_brho(@var{brho}, @bar{charge}, @var{particle})
##
## Evaluate Kinetic energy from Brho and chanrge number.
##
## @table @code
## @item @var{brho}
## B*rho [T*m]
##
## @item @var{charge}
## charge number
##
## @item @var{particle}
## The kind of the particle. "proton", "helium", "carbon" or mass number.
##
## @end table
## @end deftypefn

##== History
## 2008-03-17
## * first implementaion

function result = mev_with_brho(brho, charge, particle)
  result = mev_with_momentum(charge*brho, particle);
endfunction