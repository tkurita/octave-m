## -*- texinfo -*-
## @deftypefn {Function File} {@var{qflist} =} eq_charge_dist(@var{z}, @var{particle}, @var{mev})
## 
## Obtain fractions of charge states around equilibrium charge state.
## The charge states of which fraction is above 0.05 are outputed.
## If output variable is not specified, 
## print distribution of equilibirium charge state.
##
## Input parameters are follows.
## @table @code
## @item @var{z}
## Atomic number
## @item @var{particle}
## Mass number
## @item @var{mev}
## Kinetic Energy in MeV
## @end table
##
## Here is the structure of output.
## @example
## [charge1, fractoion1; charge2, fraction2; ...]
## @end example
##
## @seealso{eq_charge}
## @end deftypefn

##== History
## 2009-04-09
## * can have an output argument.
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
  if (nargout > 0)
    retval = [qlist(:), fracs(:)];
    retval(retval(:,2) <= 0.05, :) = [];
  else
    for n=1:length(qlist)
      if (fracs(n) > 0.05)
        printf("%2d+ : %.3f\n", qlist(n), fracs(n));
      endif
    endfor
  endif
endfunction

%!test
%! eq_charge_dist(x)
