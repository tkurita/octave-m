## usage : outRec = calcLatticeForTune(targetRec)
## obsolete. Use lattice_with_tune
##= Parameters
## * targetRec
##      .measured_tune.h -- horizontal tune
##      .measured_tune.v -- vertical tune
##
##= Result
## * outputRec
##      .lattice
##      .tune
##      .qfk
##      .qdk

##= History
## 2007-10-18
## * obsolete. use lattice_with_tune
## 2006.10.12
## * calcLatticeSimple ではなく、calcWERCLattice を使うように変更
## 2006.09.28
## * vedge の値を 0にした。

function targetRec = calcLatticeForTune(targetRec)
  arguments = {targetRec.measured_tune.h, targetRec.measured_tune.v};
  if (isfield(targetRec, "initial_qfk"))
    arguments = {arguments{:}, targetRec.initial_qfk};
    arguments = {arguments{:}, targetRec.initial_qdk};
  endif
  
  [qfk, qdk] = searchQValue(arguments{:});
  [targetRec.lattice, targetRec.tune] = calcWERCLattice(qfk, qdk, 0);
  targetRec.qfk = qfk;
  targetRec.qdk = qdk;
endfunction
