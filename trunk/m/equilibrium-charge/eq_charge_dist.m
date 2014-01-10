## -*- texinfo -*-
## @deftypefn {Function File} {@var{qflist} =} eq_charge_dist(@var{z}, @var{particle}, @var{mev}, [@var{opts}])
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
##
## Here is labels of options.
## @table @code
## @item stripper
## "gas" or "carbon". 
## @item minq
## @item maxq
## @item threshold
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
## 2014-01-10
## * maximum and deviation will be displayed.
## 2009-06-12
## * use Sayer's distribution. R.O.Sayer Review. de. Phys. App. 12(’77)1543
## 2009-06-11
## * add options "minq", "maxq", "threshold"
## 2009-04-09
## * can have an output argument.
## 2008-12-09
## * First implementation

function retval = eq_charge_dist(varargin)
  if (nargin < 3)
    print_usage();
  endif
  # mev = 15
  # z = 29
  # particle = 64
  # 
  # z, particle, mev, 
  [args, prop] = parseparams(varargin);
  [z, particle, mev] = div_elem(args);
  opts = get_properties(prop, 
                      {"stripper", "minq", "maxq", "threshold"}, 
                      {"gas", 1, z, 0.05});
  b = beta_with_mev(mev, particle);
  switch (opts.stripper)
    case "gas"
      q0 = z*(1-1.08*exp(-80.1*z.^(-0.504)*b.^0.996));
      rho = 0.35*z^0.55*((q0/z)*(1-q0/z))^0.27;
      epsi = rho*(0.17+0.0012*z-3.3*b);
    case "carbon"
      q0 = z*(1-1.03*exp(-47.3*z^(-0.38)*b^0.86));
      rho = 0.48*z^0.45*((q0/z)*(1-q0/z))^0.26;
      epsi = rho*(0.0007*z-0.7*b);
    otherwise
      error("stripper must be \"gas\" or \"carbon\".");
  endswitch
  if (q0 < 0) 
    error("Out of estimation range. Energy is too small.");
  endif
  #[q, dq] = eq_charge(z, particle, mev)
  #rho
  # q0
  # rho
  # epsi
  qlist = floor(opts.minq):1:ceil(opts.maxq);
  t = (qlist - q0)/rho;
  fq = exp(-0.5*t.^2./(1 + epsi*t));
  #fracs = gaussianx(qlist, 0, dq, q);
  #[qlist(:), fracs(:)]
  fracs = fq/sum(fq);
  #[qlist(:), fracs(:)]
  if (nargout > 0)
    retval = [qlist(:), fracs(:)];
    retval(retval(:,2) <= opts.threshold, :) = [];
  else
    printf("  maximum : %.3f\n", q0);
    printf("deviation : %.3f\n", rho);
    for n=1:length(qlist)
      if (fracs(n) > opts.threshold)
    printf("      %2d+ : %.3f\n", qlist(n), fracs(n));
      endif
    endfor
  endif
endfunction

%!test
%! eq_charge_dist(6, 12, 25, "stripper", "gas")
