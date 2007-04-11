## usage : outCODList = shiftCODWithPerror(inCODList, inStruct)
##
##= Parameters
## * inStruct
##  .lattice
##  .pError
##  .horv
## * inCODList -- [position; COD at position]
##
##= Result
## * outCODList -- [position; COD shifted with dispersion and pError]

function outCODList = shiftCODWithPerror(inCODList, inStruct)
  positionList = [];
  dispersionList = [];
  
  for m = 1:length(inStruct.lattice)
    currentElement = inStruct.lattice{m};
    positionList = [positionList;
    currentElement.centerPosition; currentElement.exitPosition];
    
    dispersionList = [dispersionList;
    currentElement.centerDispersion; currentElement.exitDispersion];
  endfor
  
  diffCODList = dispersionList*inStruct.pError*1000;
  y = interp1(positionList, diffCODList, inCODList(:,1), "linear", "extrap");
  outCODList = [inCODList(:,1), inCODList(:,2) + y];
endfunction

    