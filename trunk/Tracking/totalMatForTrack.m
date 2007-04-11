function result = totalMatForTrack(latticeArray)
  result = {};
  for i = 1:length(latticeArray)
    totMat.h = eye(3);
    totMat.v = eye(3);
    pCells = latticeArray{i};
    for j = 1:length(pCells)
      cell = pCells{j};
      totMat.h = cell.mat.h * totMat.h;
      totMat.v = cell.mat.v * totMat.v;
    endfor
    totMat = [totMat.h(1:2,1:2), zeros(2); zeros(2), totMat.v(1:2,1:2) ];
    result = {result{:},totMat};
  endfor
endfunction
  