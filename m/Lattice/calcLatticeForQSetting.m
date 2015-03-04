function result = calcLatticeForQSetting(qfGL, qdGL, qCalibRec, brho)
  qkRec = qkWithCalibration(qfGL, qdGL, qCalibRec, brho);
  [result.lattice, result.tune] = calcLatticeSimple(qkRec.qfk, qdkRec.qdk, qCalibRec.vedge);
endfunction