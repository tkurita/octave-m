## usage : result = indexInVector(theVector, theValue)
##
## vector の中で 最初に見つかった val を削除する

function vector = removeInVector(vector, val)
  
  ind = indexInVector(vector, val);
  if (ind > 0)
    vector(ind) = [];
  endif
  
endfunction