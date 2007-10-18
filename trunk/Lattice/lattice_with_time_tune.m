## -*- texinfo -*-
## @deftypefn {Function File} {@var{lattice_rec} =} lattice_with_time_tune(@var{lattice_rec})
##
## Calculate lattice at time spedified with 'time' field of @var{lattice_rec}.
## If 'measured_tune' field is given, 'qfk' and 'qdk' is evaluate with 'calcLatticeForTune' to match with measured_tune.
## 
## @var{lattice_rec} can have following fields
##
## @table @code
## @item time
## time [msec] in Magnet pattern. brho is obtained from function 'BMPattern' at 'time'
##
## @item measured_tune
## Optional. if this field exists, qfk and qdk is evaluated by function 'calcLatticeForTune'
## @end table
## 
## Following fields are append into @var{lattice_rec} as a result.
##
## @table @code
## @item lattice
## @item tune
## @item brho
## @item qfk
## @item qdk
##
## @end table
## 
## @seealso{calcLatticeForTune}
## @end deftypefn
#shareTerm /Users/tkurita/WorkSpace/ÉVÉìÉNÉçÉgÉçÉì/2007.10 Tracking/extraction_tracking.m

##== History
## 2007-10-18
## * use lattice_with_tune instead of calcLatticeForTune

function lattice_rec = lattice_with_time_tune(lattice_rec)
  # lattice_rec = lat_rec_FT
  lattice_rec.qfk = QKValueAtTime(QFPattern, BMPattern, lattice_rec.time);
  lattice_rec.qdk = QKValueAtTime(QDPattern, BMPattern, lattice_rec.time, -1);
  lattice_rec.brho = BrhoAtTime(BMPattern, lattice_rec.time);
  lattice_rec = calc_lattice(lattice_rec);
  
  if (isfield(lattice_rec, "measured_tune"))
    lattice_rec.initial_qfk = lattice_rec.qfk;
    lattice_rec.initial_qdk = lattice_rec.qdk;
    lattice_rec = lattice_with_tune(lattice_rec);
  endif

endfunction
