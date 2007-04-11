## usage : getElementWithName(allElements,theName)
## 
## allElements is cell array which elements are data structures.
## find an element of allElements whose name field matches theName.

function targetElement = getElementWithName(allElements,theName)
  for n = 1:length(allElements)
	if (strcmp (allElements{n}.name, theName))
	  targetElement = allElements{n};
	  break;
	endif
  endfor
endfunction