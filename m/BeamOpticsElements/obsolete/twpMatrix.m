##== build matirx for twis parameter
function twpmat = twpMatrix(matrix)
  warning("twpMatrix is deprecated. Use twp_matrix");
  twpmat = [matrix(1,1)^2, -2*matrix(1,1)*matrix(1,2), matrix(1,2)^2;
  -matrix(2,1)*matrix(1,1), 1+2*matrix(1,2)*matrix(2,1), -matrix(1,2)*matrix(2,2);
  matrix(2,1)^2, -2*matrix(2,2)*matrix(2,1), matrix(2,2)^2];
endfunction