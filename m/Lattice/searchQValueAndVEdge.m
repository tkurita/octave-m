## function result = searchQValueAndVEdge(tune1, tune2,  QFDRatio, delQFRatio, delQDRatio)
## 
##= arguments
## (tune, QFDRatio)
## (tune1, tune2, delQFRatio, delQDRatio)
## (tune1, tune2,  QFDRatio, delQFRatio, delQDRatio)
function result = searchQValueAndVEdge(varargin)
  
  initialQValue = 1.2;
  initialVedge = 0;
  global _QFDRatio;
  global _delQFRatio;
  global _delQDRatio;
  nargs = length(varargin);
  switch nargs
    case 2
      initialValues = [initialQValue; initialVedge];
      targetX = [1;2];
      targetY = [varargin{1}.h; varargin{1}.v];
      _QFDRatio = varargin{2};
      F = @calcTune;
    case 4
      initialValues = [initialQValue; initialQValue; initialVedge];
      targetX = [1;2;3;4];
      targetY = [varargin{1}.h; varargin{1}.v; varargin{2}.h; varargin{2}.v];
      _delQFRatio = varargin{3};
      _delQDRatio = varargin{4};      
      F = @calcTwoTunesWithFreeQ;  
    case 5
      initialValues = [initialQValue; initialVedge];
      _QFDRatio = varargin{3};
      _delQFRatio = varargin{4};
      _delQDRatio = varargin{5};
      targetX = [1;2;3;4];
      targetY = [varargin{1}.h; varargin{1}.v; varargin{2}.h; varargin{2}.v];
      F = @calcTwoTunes;
    otherwise
      error("number of arguments must be 2, 4 or 5\n");
  endswitch
  
  #  switch (length(varargin))
  #    case (0)
  #      #initialValues = [1.7833; 1.7249];
  #      initialValues = [1.3; 1.3];
  #      #initialValues = [0.5; 3];
  #    case (1)
  #      initialValues = varargin{1};
  #    case (2)
  #      initialValues = [varargin{1}; varargin{2}];
  #    otherwise
  #      error ("optional argument must be less than 2");
  #  endswitch
  
  #stol=0.01; 
  stol=0.0001; 
  niter=10;
  global verbose;
  verbose=1;
  [f1, leasqrResults, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r21] = ...
  leasqr (targetX, targetY, initialValues, F, stol, niter);
  
  vedge = leasqrResults(end);
  qfk = leasqrResults(1);
  switch nargs
    case 4
      qdk = leasqrResults(2);
      result = tar(qfk, qdk, vedge);
    otherwise
      QFDRatio = _QFDRatio;
      qdk = qfk * _QFDRatio;
      result = tar(qfk, qdk, vedge, QFDRatio);
  endswitch
endfunction


function result = calcTune(dummy, qValues)
  global _QFDRatio;
  qfVal1 = qValues(1);
  qdVal1 = qfVal1 * _QFDRatio;
  vedge = abs(qValues(end));
  [lattice, tune1] = calcLatticeSimple(qfVal1, qdVal1, vedge);
  
  result = [tune1.h; tune1.v];
endfunction

function result = calcTwoTunesWithFreeQ(dummy, qValues)
  printf("start calcTwoTunesWithFreeQ\n");
  global _delQFRatio;
  global _delQDRatio;
  qfVal1 = qValues(1);
  qdVal1 = qValues(2);
  qfVal2 = qfVal1 * _delQFRatio;
  qdVal2 = qdVal1 * _delQDRatio;
  vedge = abs(qValues(end));
  [lattice, tune1] = calcLatticeSimple(qfVal1, qdVal1, vedge);
  [lattice, tune2] = calcLatticeSimple(qfVal2, qdVal2, vedge);
  
  result = [tune1.h; tune1.v; tune2.h; tune2.v];
endfunction

function result = calcTwoTunes(dummy, qValues)
  global _QFDRatio;
  global _delQFRatio;
  global _delQDRatio;
  qfVal1 = qValues(1);
  qdVal1 = qfVal1 * _QFDRatio;
  qfVal2 = qfVal1 * _delQFRatio;
  qdVal2 = qdVal1 * _delQDRatio;
  vedge = abs(qValues(end));
  [lattice, tune1] = calcLatticeSimple(qfVal1, qdVal1, vedge);
  [lattice, tune2] = calcLatticeSimple(qfVal2, qdVal2, vedge);
  
  result = [tune1.h; tune1.v; tune2.h; tune2.v];
endfunction
