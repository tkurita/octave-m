## usage:[lattice, tune] = calcWERCLattice(qfk, qdk, [vedge])
## 
## Q の値を与えて lattice と tune の結果だけを返す。
## to obtain
## = Parameters
## * qfk -- [(T/m) *m]
## * qdk
## * vedge
##
## = Results
## * lattice
## * tune

##== History
## 2007-10-18
## * obsolete. use calc_lattice
##

function [lattice,tune] = calcWERCLattice(qfk, qdk, varargin)
  warning("calcWERCLattice is obsolete. Use calc_lattice.");
  
  lattice = buildWERCMatrix(qfk, qdk, varargin{:});
  fullCircleMat.h = calcFullCircle(lattice,"h");
  fullCircleMat.v = calcFullCircle(lattice,"v");
  [betaFunction, dispersion, totalPhase, lattice] = calcLattice(lattice, fullCircleMat);
  
  tune.v = totalPhase.v/(2*pi);
  tune.h = totalPhase.h/(2*pi);
endfunction
