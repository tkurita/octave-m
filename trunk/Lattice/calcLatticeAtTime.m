## usage : inputRec = calcLatticeAtTime(inputRec)
##
##= Parameters
## * inputRec
##      .time -- msec from starting the magnet pattern
##
##= Result
## * inputRec
##      .lattice
##      .tune
##      .brho
##      .qfk
##      .qdk

function inputRec = calcLatticeAtTime(inputRec)
  #inputRec.time = 700;
  inputRec.qfk = QKValueAtTime(QFPattern, BMPattern, inputRec.time);
  inputRec.qdk = QKValueAtTime(QDPattern, BMPattern, inputRec.time, -1);
  inputRec.brho = BrhoAtTime(BMPattern, inputRec.time);
  [inputRec.lattice, inputRec.tune] = calcLatticeSimple(inputRec.qfk, inputRec.qdk);
  #result = inputRec;
endfunction
