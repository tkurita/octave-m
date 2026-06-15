## Usage : newmatrix = insert_column(mat, col, index)
##         new_cells = insert_column(cells, col, index)

# both of matrix and cell array can be processed with same code
function result = insert_column(mat, col, colidx)
  pre_mat = mat(:,1:colidx-1);
  post_mat = mat(:,colidx:end);
  result = [pre_mat, col, post_mat];
endfunction
  
