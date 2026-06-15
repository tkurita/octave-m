## Usage : result = insertColumn(mat, insertMat, colIndex)
function result = insertColumn(mat, insertMat, colIndex)
  warning("insertColumn is deprecated. Use insert_column");
  pre_mat = mat(:,1:colIndex-1);
  post_mat = mat(:,colIndex:end);
  result = [pre_mat, insertMat, post_mat];
endfunction
  
