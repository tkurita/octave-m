## usage : codRecord = calcCollectionValueAtTime(codRecord, t)
##
## COD �̑���l���� �X�e�A���̕␳�l���v�Z����B
## ����ɕK�v�� lattice �̌v�Z������B
##
## function BMPattern �����炩���� load ����Ă��邱�Ƃ��K�v
## (Carbon660MeVMagnet.m �������́AProton200MeVMagnet.m �ɂ���Ē񋟂����)
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