## usage : codRecord = calcCollectionValueAtTime2(codRecord, t)
##
## COD �̑���l���� �X�e�A���̕␳�l���v�Z����B
## ����ɕK�v�� lattice �̌v�Z������B
##
## function BMPattern �����炩���� load ����Ă��邱�Ƃ��K�v
## (Carbon660MeVMagnet.m �������́AProton200MeVMagnet.m �ɂ���Ē񋟂����)
## lFitCOD ���g�� -- ���`�ŏ�����@���g��
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

function codRecord = calcCollectionValueAtTime2(codRecord, t)
  codRecord.time = t;
  codRecord = calcLatticeAtTime(codRecord);
  if (isfield(codRecord, "measured_tune"))
    codRecord.initial_qfk = codRecord.qfk;
    codRecord.initial_qdk = codRecord.qdk;
    codRecord = calcLatticeForTune(codRecord);
  endif
  codRecord.brho = BrhoAtTime(BMPattern, t);
  codRecord = lFitCOD(codRecord);
  codRecord.correctCOD = calcCODWithPerror(codRecord);
  codRecord.targetCOD = buildTargetCOD(codRecord);
endfunction