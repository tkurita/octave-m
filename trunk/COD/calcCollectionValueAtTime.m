## usage : codRecord = calcCollectionValueAtTime(codRecord, t)
##
## COD の測定値から ステアラの補正値を計算する。
## これに必要な lattice の計算もする。
##
## function BMPattern があらかじめ load されていることが必要
## (Carbon660MeVMagnet.m もしくは、Proton200MeVMagnet.m によって提供される)
##
##=== parameters
## codRecord
##  .steererNames
##  .lattice
##  .horv
##
##=== result -- following members are added into codRecord
##   .time
##   .lattice
##   .tune 
##   .targetCOD
##   .correctCOD
##   .brho
##   .steererValues
##   .pError

function codRecord = calcCollectionValueAtTime(codRecord, t)
  codRecord.time = t;
  codRecord = calcLatticeAtTime(codRecord);
  codRecord.targetCOD = buildTargetCOD(codRecord);
  codRecord.brho = BrhoAtTime(BMPattern, t);
  codRecord = fitCOD(codRecord);
  codRecord.correctCOD = calcCODWithPerror(codRecord);
endfunction