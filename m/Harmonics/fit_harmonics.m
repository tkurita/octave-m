## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} fit_harmonics(@var{xy}, @var{params_init}, ["test", "plot", "print"])
## @deftypefn {Function File} {@var{retval} =} fit_harmonics(@var{file},
## @var{params_init}, ["test", "plot", "print"])
##
## description
## @strong{Inputs}
## @table @var
## @item parames_init(1)
## @item params(1)
## a1 : Amplitude of fundamental wave
## @item params_init(2)
## a2ratio : Ratio of amplitude between fundamental and second harmonics
## @item params_init(3)
## f : Frequency of fundamental wave.
## @item params_init(4)
## phis : Synchronus phase.
## @item params_inits(5)
## DC offset
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
  opts = get_properties(varargin, {"test", false; 
                                    "plot", false; 
                                    "print", false});
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
  if (nargout == 0) || opts.print
    covp1
    printf("%9s %9s %9s %9s %9s %9s\n" ...
          , "a1", "a2ratio", "f", "phis", "phi1", "offset")
    printf("%9.5g %9.5g %9.4e %9.5g %9.5g %9.5g\n" ...
          ,leasqrResults);
    printf("Errors :\n");
    printf("%9.4g %9.4g %9.4e %9.4g %9.4g %9.4g\n" ...
          , diag(covp1));
  endif
  if opts.plot
      xyplot(xy,".;data;" ...
      , rf_with_harmonics(xy(:,1), leasqrResults), "-;fit;");
  endif
endfunction

function v = fit_func(t, args)
  v = rf_with_harmonics(t, args)(:,2);
endfunction

function test_fitparams(rfw, params_init)
  xyplot(rfw,".;data;" ...
      , rf_with_harmonics(rfw(:,1), params_init), "-;test;");
endfunction