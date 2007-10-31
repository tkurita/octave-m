## useage: result = extracBeta(allElements,horv)
## 
## extarct calculated beta from allElements with matrix form.
##
## horv is a character "h" or "v"

function result = extractBeta(allElements,horv)
  result = [];
  for n = 1:length(allElements)
	theElement = allElements{n};
	theExitPosition = theElement.exitPosition;
	theBeta = theElement.exitBeta.(horv);
	result = [result;[theExitPosition,theBeta]];
  endfor
endfunction