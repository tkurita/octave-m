## usage : result = indexInVector(theVector, theValue)
##
## vector の中で theValue の index を求める。

function result = indexInVector(theVector, theValue)
	result = 0;
	for i = 1:length(theVector)
		if (theValue == theVector(i))
			result = i;
			break;
		endif
	endfor
endfunction