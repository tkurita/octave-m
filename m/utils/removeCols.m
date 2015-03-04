## usage : mat = removeCols(mat, indexes)
##

function mat = removeCols(mat, indexes)
  for i = 1:length(indexes)
    ind = indexes(i);
    mat(:,ind-(i-1)) = [];
  endfor
endfunction