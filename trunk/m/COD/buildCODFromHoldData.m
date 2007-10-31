## usage : codRecord = buildCODFromHoldData(codRecord, fileName, FBorFT)
##
## append following fields into codRecord.
## * .codAtBPM -- measured COD at BPM
## * .targetCOD -- matrix of [BPM position, COD at BPM]

function codRecord = buildCODFromHoldData(codRecord, fileName, FBorFT)
  codRecord.codAtBPM = getCODFromHoldData(fileName, FBorFT);
  codRecord.targetCOD = buildTargetCOD(codRecord);
endfunction