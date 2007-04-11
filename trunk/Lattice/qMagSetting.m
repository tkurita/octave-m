## usage : qValRec = qMagSetting(qValRec, qCalibRecord, brho)
##
##= arguments
## * qValues
##      .qfk
##      .qdk
## * qCalibRecord -- output of searchQCalibration
## * brho
##
##= result
## following field are added into qValRec
##      .qfSet -- [GL]
##      .qdSet -- [GL]

function qValRec = qMagSetting(qValRec, qCalibRecord, brho)
  # qValRec = rec;
  qfSet = (qValRec.qfk * brho - qCalibRecord.qfkOffset)*qCalibRecord.qfkLengthFactor;
  qdSet = (qValRec.qdk * brho - qCalibRecord.qdkOffset)*qCalibRecord.qdkLengthFactor;
  qValRec.qfSet = qfSet;
  qValRec.qdSet = qdSet;
endfunction