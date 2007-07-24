## usage : lattice_rec = lattice_with_time_tune(lattice_rec)
##  calculate lattice at time spedified with time field.
##  If measured_tune field is given run calcLatticeForTune 
##  to fit qfk and qdk to match with measured_tune.
##  
##= Parameters
## * lattice_rec
##      .time -- msec from starting the magnet pattern
##
##= Result
## * lattice_rec
##      .lattice
##      .tune
##      .brho
##      .qfk
##      .qdk

function lattice_rec = lattice_with_time_tune(lattice_rec)
  #lattice_rec.time = 700;
  lattice_rec.qfk = QKValueAtTime(QFPattern, BMPattern, lattice_rec.time);
  lattice_rec.qdk = QKValueAtTime(QDPattern, BMPattern, lattice_rec.time, -1);
  lattice_rec.brho = BrhoAtTime(BMPattern, lattice_rec.time);
  [lattice_rec.lattice, lattice_rec.tune] = calcLatticeSimple(lattice_rec.qfk, lattice_rec.qdk);
  #result = lattice_rec;
  
  if (isfield(lattice_rec, "measured_tune"))
    lattice_rec.initial_qfk = lattice_rec.qfk;
    lattice_rec.initial_qdk = lattice_rec.qdk;
    lattice_rec = calcLatticeForTune(lattice_rec);
  endif

endfunction
