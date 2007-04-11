## usage plotPhaseAdvance(allElements)
##
## plot phase advance of each element in allElements.
## allElements is a cell array which contains data structures.
## elements in allElements must have exitPhase field and exitPosition field.

function plotPhaseAdvance(allElements)
  phaseSet.h = [];
  for n = 1:length(allElements)
	theElement = allElements{n}
	phaseSet.h = [phaseSet.h;theElement.exitPosition,theElement.exitPhase.h]
  endfor
  gplot phaseSet.h
endfunction