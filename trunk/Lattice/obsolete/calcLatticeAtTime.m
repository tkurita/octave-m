## usage : inputRec = calcLatticeAtTime(inputRec)
##  calculate lattice at time spedified with time field.
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
  warning("obsolute, use lattice_with_time_tune");
  #inputRec.time = 700;
  inputRec.qfk = QKValueAtTime(QFPattern, BMPattern, inputRec.time);
  inputRec.qdk = QKValueAtTime(QDPattern, BMPattern, inputRec.time, -1);
  inputRec.brho = BrhoAtTime(BMPattern, inputRec.time);
  [inputRec.lattice, inputRec.tune] = calcLatticeSimple(inputRec.qfk, inputRec.qdk);
  #result = inputRec;

endfunction
