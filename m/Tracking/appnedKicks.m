##
##=Parameters
## * latRec
##      .lattice
##      .brho
##      .kickerNames
##      .kickerValues

function latRec = appendBMPeKick(latRec)
  for i = 1:length(latRec.lattice);
    theElement = latRec.lattice{i};
    for j = 1:length(latRec.kickerNames)
      if (strcmp(theElement.name, latRec.kickerNames{j}))
        kickAngle = calcSteerAngle(theElement, latRec.kickerValues(j), latRec.brho);
        kickMat = [1, 0;
        
  endfor
endfunction
