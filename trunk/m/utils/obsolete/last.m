## usage: theElement = last(theMatrix)
##
## return last element of matrix A(length(A))
## use "end" index like A(end)

function theElement = last(theMatrix)
  theElement = theMatrix(length(theMatrix));
endfunction