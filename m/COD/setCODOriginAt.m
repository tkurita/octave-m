## usage : outCODList = setCODOriginAt(inCODList, lattice, elemName)

function outCODList = setCODOriginAt(inCODList, lattice, elemName)
  theElem = getElementWithName(lattice, elemName);
  y = interp1(inCODList(:,1), inCODList(:,2), theElem.centerPosition, "linear", "extrap");
  delPFactor = y/(theElem.centerDispersion * 1000);
  
  positionList = [];
  dispersionList = [];
  
  for m = 1:length(lattice)
    currentElement = lattice{m};
    if currentElement.len > 0 # to avoid same position values
      positionList(end+1) = currentElement.centerPosition;
      positionList(end+1) = currentElement.exitPosition;
      dispersionList(end+1) = currentElement.centerDispersion;
      dispersionList(end+1) = currentElement.exitDispersion;
    endif
  endfor
  diffCODList = dispersionList*delPFactor*1000;
  y = interp1(positionList, diffCODList, inCODList(:,1), "linear", "extrap");
  outCODList = [inCODList(:,1), inCODList(:,2) - y];
endfunction
