## usage : function [qfk, qdk] = searchQValue(tunex, tuney[, initial_qfk, initial_qdk])
##

##== History
## 2007-10-18
## * should be obsolete. use search_qk
## 2006-09-28
## * assume vedge : 0

function [qfk, qdk] = searchQValue(tunex, tuney, varargin)
  stol=0.01; 
  #stol=0.0001; 
  niter=5;
  switch (length(varargin))
    case (0)
      #initialValues = [1.7833; 1.7249];
      initialValues = [1.3; 1.3];
      #initialValues = [0.5; 3];
    case (1)
      initialValues = varargin{1};
    case (2)
      initialValues = [varargin{1}; varargin{2}];
    otherwise
      error ("optional argument must be less than 2");
  endswitch
  
  global verbose;
  verbose=1;
  F = @calcTune;
  [f1, leasqrResults, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r21] = ...
  leasqr ([1;2], [tunex; tuney], initialValues, F, stol, niter);
  
  qfk = leasqrResults(1);
  qdk = leasqrResults(2);
endfunction

function result = calcTune(dummy, qValues)
  allElements = buildWERCMatrix(qValues(1),qValues(2), 0);
  latRec = calcLattice(allElements);
  result = [latRec.tune.h; latRec.tune.v];
endfunction

#searchQValue(1.68, 0.79)