## usage : outCODList = shiftCODWithPerror(inCODList, inStruct)
##  
## obsolute use shift_cod_with_perror
##= Parameters
## * inStruct
##    .lattice
##    .pError
##    .horv
## * inCODList -- [position; COD at position]
##
##= Result
## * outCODList -- [position; COD shifted with dispersion and pError]

##= History
## * 2007.09.28
## obsolute

function outCODList = shiftCODWithPerror(inCODList, inStruct)
  warning("shiftCODWithPerror is obsolute, use shift_cod_with_perror");
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

    