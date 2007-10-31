## useage: printBeta(allElements,horv)
## 
## print calculated beta stored in allElements.
##
## horv is a character "h" or "v"

function printBeta(allElements,horv)
  printf("%s\t%s\t%s\n","name","exit_position[m]", "beta function at exit[m]")
  for n = 1:length(allElements)
	theElement = allElements{n};
	theName = theElement.name;
	theExitPosition = theElement.exitPosition;
	theBeta = theElement.exitBeta.(horv);
	printf("%s\t%f\t%f\n", theName,theExitPosition,theBeta);
  endfor

endfunction