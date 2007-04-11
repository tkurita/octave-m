## usage : result = getCODAtElement(codRecord, codField, elemName)
##
## get COD at center position of the element of which name is elemName
##
##= Parameters
##  * codRecord
##      .lattice
##      .(codField)
##  * codField -- specify field name in codRecord to use
##  * elemName -- name of the element
##
##= Result
## COD [mm] at center position of elemName

function result = getCODAtElement(codRecord, codField, elemName)
  centerPosition = getElementWithName(codRecord.lattice, elemName).centerPosition;
  codList = codRecord.(codField);
  result = interp1(codList(:,1), codList(:,2), centerPosition, "linear", "extrap");
endfunction