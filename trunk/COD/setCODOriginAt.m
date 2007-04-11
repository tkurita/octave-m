## usage : outCODList = setCODOriginAt(inCODList, lattice, elemName)

function outCODList = setCODOriginAt(inCODList, lattice, elemName)
  theElem = getElementWithName(lattice, elemName);
  y = interp1(inCODList(:,1), inCODList(:,2), theElem.centerPosition, "linear", "extrap");
  delPFactor = y/(theElem.centerDispersion * 1000);
  
  positionList = [];
  dispersionList = [];
  
  for m = 1:length(lattice)
    currentElement = lattice{m};
    positionList = [positionList;
    currentElement.centerPosition; currentElement.exitPosition];
    
    dispersionList = [dispersionList;
    currentElement.centerDispersion; currentElement.exitDispersion];
  endfor
  
  diffCODList = dispersionList*delPFactor*1000;
  y = interp1(positionList, diffCODList, inCODList(:,1), "linear", "extrap");
  outCODList = [inCODList(:,1), inCODList(:,2) - y];
endfunction
