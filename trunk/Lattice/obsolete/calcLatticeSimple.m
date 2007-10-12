## usage:[lattice, tune] = calcLatticeSimple(qfk, qdk, [vedge])
## 
## Q の値をを与えて lattice と tune の結果だけを返す。
##
## = Parameters
## * qfk -- [(T/m) *m]
## * qdk
## * vedge
## = Results
## * lattice
## * tune

## = History
## 2006.10.12 -- 今後は、calcWERCLattice を使う

function [lattice,tune] = calcLatticeSimple(qfk, qdk, varargin)
  
  lattice = buildWERCMatrix(qfk, qdk, varargin{:});
  fullCircleMat.h = calcFullCircle(lattice,"h");
  fullCircleMat.v = calcFullCircle(lattice,"v");
  [betaFunction, dispersion, totalPhase, lattice] = calcLattice(lattice, fullCircleMat);
  
  tune.v = totalPhase.v/(2*pi);#result 0.810899
  tune.h = totalPhase.h/(2*pi);#result 1.76185
  ## show tunes
  # printTune(tune);
endfunction
