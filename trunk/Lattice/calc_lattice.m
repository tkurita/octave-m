## -*- texinfo -*-
## @deftypefn {Function File} {[@var{lattice}, @var{tune}] =} calc_lattice(@var{qfk}, @var{qdf}, [@var{vedge}])
##
## Return evaluated lattice and tune with given Q values.
## The lattice definition is given by function 'lattice_definition'
##
## Parameters
##
## @table @code
## @item qfk
## [(T/m) *m]
## @item qdk
## @item vedge
## optional
## @end table
##
## Results
##
## @table @code
## @item lattice
## a cell array
## @item tune
## a structure. Fields 'h' and 'v' are horizontal and vertical tune respectively.
## @end table
##
## @seealso{lattice_definition, process_lattice}
## @end deftypefn

##== History
## 2007-10-18
## * defiverd from calcWERCLattice

function [lattice,tune] = calc_lattice(qfk, qdk, varargin)
  lattice_def = lattice_definition();
  lattice = lattice_def(qfk, qdk, varargin{:});
  fullCircleMat.h = calcFullCircle(lattice,"h");
  fullCircleMat.v = calcFullCircle(lattice,"v");
  [betaFunction, dispersion, totalPhase, lattice] = process_lattice(lattice, fullCircleMat);
  
  tune.v = totalPhase.v/(2*pi);
  tune.h = totalPhase.h/(2*pi);
endfunction
