## Usage : result = mat_for_tracking(elements)
##
##== Parameters
## * elements : a cell array of elements of a lattice

##== History
## 2007-10-03
## * derived from totalMatForTrack
## * add support dispersion 

function result = mat_for_tracking(elements)
  result = {};
  for i = 1:length(elements)
    totMat.h = eye(3);
    totMat.v = eye(3);
    pCells = elements{i};
    for j = 1:length(pCells)
      a_cell = pCells{j};
      totMat.h = a_cell.mat.h * totMat.h;
      totMat.v = a_cell.mat.v * totMat.v;
    endfor
    totMat = [totMat.h, zeros(3); zeros(3), totMat.v ];
    result = {result{:},totMat};
  endfor
endfunction
  