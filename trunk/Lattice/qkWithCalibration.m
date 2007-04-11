function result = qkWithCalibration(qfGL, qdGL, qCalibRec, brho)
  result.qfk = (qfGL/qCalibRec.qfkLengthFactor + qCalibRec.qfkOffset)/brho;
  result.qdk = (qfGL/qCalibRec.qfkLengthFactor + qCalibRec.qdkOffset)/brho;
endfunction
