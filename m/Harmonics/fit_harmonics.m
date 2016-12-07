## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} fit_harmonics(@var{xy}, @var{params_init}, ["test"])
## @deftypefn {Function File} {@var{retval} =} fit_harmonics(@var{file},
## @var{params_init}, ["test"])
##
## description
## @strong{Inputs}
## @table @var
## @item arg1
## description of @var{arg}
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## description of @var{retval}
## @end table
##
## @end deftypefn

function leasqrResults = fit_harmonics(indata, params_init, varargin) 
  if ischar(indata)
    xy = xy(isf_data(indata));
  else
    xy = indata;
  endif
  opts = get_properties(varargin, {"test", false});
  if opts.test
    test_fitparams(xy, params_init);
    return;
  endif

  pkg load optim
  more off;
  F = @fit_func;
  stol=0.0001; 
  niter=500;

  [f1, leasqrResults, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r21] = ...
        leasqr(xy(:,1), xy(:,2), params_init, F, stol, niter);
  if nargout == 0 
    covp1
    printf("%9s %9s %9s %9s %9s %9s\n" ...
          , "a1", "a2ratio", "f", "phis", "phi1", "offset")
    printf("%9.5g %9.5g %9.4e %9.5g %9.5g %9.5g\n" ...
          ,leasqrResults);
    printf("Errors :\n");
    printf("%9.4g %9.4g %9.4e %9.4g %9.4g %9.4g\n" ...
          , diag(covp1));
  endif
endfunction

function v = fit_func(t, args)
  v = rf_with_harmonics(t, args)(:,2);
endfunction

function test_fitparams(rfw, params_init)
  xyplot(rfw,".", rf_with_harmonics(rfw(:,1), params_init), "-");
endfunction