function printBetaPhase(allElements,horv)
  printf("%s\t%s\t%s\t%s\t%s\n","name","center_beta", "exit_beta","center_phase","exit_phase")
  for n = 1:length(allElements)
    theElement = allElements{n};
    theName = theElement.name;
    #	theExitPosition = theElement.exitPosition;
    theExitPhase = theElement.exitPhase.(horv);
    theCenterPhase = theElement.centerPhase.(horv);
    theExitBeta = theElement.exitBeta.(horv);
    theMeanBeta = theElement.meanBeta.(horv);
    #	theDispersion = theElement.eater(1);
    printf("%s\t%f\t%f\t%f\t%f\n", theName, theMeanBeta, theExitBeta, theCenterPhase, theExitPhase);
  endfor
  
endfunction