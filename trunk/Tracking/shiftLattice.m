## usage : shiftedElements = shiftLattice(allElements, newFirstElement)

function shiftedElements = shiftLattice(allElements, newFirstElement)
  
  for i = 1:length(allElements)
    if (strcmp(allElements{i}.name, newFirstElement))
      splitPosition = i;
    endif
  endfor
  
  shiftedElements = shift(allElements, -(splitPosition-1));
endfunction

    