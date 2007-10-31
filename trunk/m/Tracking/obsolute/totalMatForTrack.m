##== History
## 2007-10-03
## * should be obsolute, because dispersion is not supported.
## * new function is mat_for_tracking

function result = totalMatForTrack(latticeArray)
  result = {};
  for i = 1:length(latticeArray)
    totMat.h = eye(3);
    totMat.v = eye(3);
    pCells = latticeArray{i};
    for j = 1:length(pCells)
      a_cell = pCells{j};
      totMat.h = a_cell.mat.h * totMat.h;
      totMat.v = a_cell.mat.v * totMat.v;
    endfor
    totMat = [totMat.h(1:2,1:2), zeros(2); zeros(2), totMat.v(1:2,1:2) ];
    #totMat = [totMat.h, zeros(3); zeros(3), totMat.v ];
    result = {result{:},totMat};
  endfor
endfunction
  