## usage : codRecord = cod_correction_at_time(codRecord, t)
##
## COD の測定値から ステアラの補正値を計算する。
## これに必要な lattice の計算もする。
##
## function BMPattern があらかじめ load されていることが必要
## (Carbon660MeVMagnet.m もしくは、Proton200MeVMagnet.m によって提供される)
## lFitCOD を使う -- 線形最小自乗法を使う
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

function codRecord = cod_correction_at_time(codRecord, t)
  codRecord.time = t;
  codRecord = lattice_with_time_tune(codRecord);
  codRecord = lFitCOD(codRecord);
  codRecord.correctCOD = calcCODWithPerror(codRecord);
  codRecord.targetCOD = buildTargetCOD(codRecord);
endfunction