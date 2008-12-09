## -*- texinfo -*-
## @deftypefn {Function File} {} eq_charge_dist(@var{z}, @var{particle}, @var{mev})
##
## Print distribution of equilibirium charge state
##
## @table @code
## @item @var{z}
## Atomic number
## @item @var{particle}
## Mass number
## @item @var{mev}
## Kinetic Energy in MeV
## @end table
##
## @seealso{eq_charge}
## @end deftypefn

##== History
## 2008-12-09
## * First implementation

function retval = eq_charge_dist(z, particle, mev)
  # mev = 15
  # z = 29
  # particle = 64
  [q, dq] = eq_charge(z, particle, mev);
  minq = q-3*dq; 
  if (minq < 0)
    minq = 0;
  endif
  qlist = floor(minq):1:ceil(q+3*dq);
  fracs = gaussianx(qlist, 0, dq, q);
  #[qlist(:), fracs(:)]
  fracs = fracs/sum(fracs);
  #[qlist(:), fracs(:)]
  for n=1:length(qlist)
    if (fracs(n) > 0.05)
      printf("%2d+ : %.3f\n", qlist(n), fracs(n));
    endif
  endfor
  
endfunction

%!test
%! eq_charge_dist(x)
