function printDispersion(allElements)
  printf("%s\t%s\t%s\n","name","exit_position[m]", "dispersion[m]")
  for n = 1:length(allElements)
	theElement = allElements{n};
	theName = theElement.name;
	theExitPosition = theElement.exitPosition;
	theDispersion = theElement.eater(1);
	printf("%s\t%f\t%f\n", theName,theExitPosition,theDispersion);
  endfor

endfunction