## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} fit_vaccum_distribution(@var{arg})
##
## @end deftypefn

##== History
##

function varargout = fit_vaccum_distribution(vdist, initv)
  # initv = [0.5e-7, 6.3841e-06, 1.1514e-05]
  # vdist = vac20100204
  stol=0.01;
  #stol=0.0001; 
  niter=5;
  global verbose;
  verbose=1;
  target_values = vdist(:,2);
  F = @_calc_vdist;
   [f1, leasqr_results, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r21] = ...
  leasqr(vdist(:,1), target_values(:), initv(:), F, stol, niter);
  varargout = {leasqr_results};
  if nargout > 1
    varargout{end+1} = calc_vaccum_distribution(leasqr_results(1), leasqr_results(2), leasqr_results(3));
  endif
endfunction

function retval = _calc_vdist(x, inval)
  [q_base, q_esi, q_esd] = div_elem(inval);
  xp = calc_vaccum_distribution(q_base, q_esi, q_esd);
  retval = interp1(xp(:,1), xp(:,2), x);
endfunction

%!test
%! fit_vaccum_distribution(vdist)
