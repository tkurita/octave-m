## Usage : result = gaussianFit([x,y] [, initial_values])
##         result = gaussianFit(x, y [, initial_values])
##         result = gaussianFit([x,y], initial_values)
##                  gaussinaFit("setting", value) -- not implemented
##
## = Parameters
## * initial_values = [amp, sigma, mu]

##== History
## 2008-01-09
## * obsolete. use gaussian-fit

function result = gaussianFit(varargin)
  warning("gaussianFit is obsolete. Use gaussian_fit");
  persistent initial_values = [1, 1, 0];
  persistent stol = 0.00000001;
  persistent niter = 500;
  global verbose = 1;
  
  if (isvector(varargin{1}))
    xlist = varargin{1};
    ylist = varargin{2};
    next_arg = 3;
    
  elseif (ismatrix(varargin{1}))
    xlist = varargin{1}(:,1);
    ylist = varargin{1}(:,2);
    next_arg = 2;
    
  endif
  
  if (length(varargin)  >= next_arg)
    initial_values = varargin{next_arg};
  endif
  
  F = @gaussian;
  [f1, result, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r21] = ...
  leasqr(xlist, ylist, initial_values, F, stol, niter);
  
endfunction

