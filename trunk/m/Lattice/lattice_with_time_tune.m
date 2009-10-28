## -*- texinfo -*-
## @deftypefn {Function File} {@var{lattice_rec} =} lattice_with_time_tune(@var{lattice_rec})
##
## Calculate lattice at time spedified with 'time' field of @var{lattice_rec}.
## If 'measured_tune' field is given, 'qfk' and 'qdk' is evaluate with 'lattice_with_tune' to match with measured_tune.
## 
## @var{lattice_rec} can have following fields
##
## @table @code
## @item time
## time [msec] in Magnet pattern. brho is obtained from function 'BMPattern' at 'time'
##
## @item measured_tune
## Optional. if this field exists, qfk and qdk is evaluated by function 'lattice_with_tune'
## @end table
## 
## Following fields are append into @var{lattice_rec} as a result.
##
## @table @code
## @item lattice
## @item tune
## @item brho
## @item qfk
## [1/(m*m)]
## @item qdk
##
## @end table
## 
## @seealso{lattice_with_tune, lattice_with_time, lattice_definition}
## @end deftypefn

##== History
## 2008-07-25
## * Use qk_at_time instead of QKValueAtTime
## * Add support of beta function fitting.
## 
## 2007-10-18
## * use lattice_with_tune instead of calcLatticeForTune

function lattice_rec = lattice_with_time_tune(lattice_rec)
  # lattice_rec = lat_rec_FT
  lattice_rec.qfk = qk_at_time(QFPattern, BMPattern, lattice_rec.time);
  lattice_rec.qdk = qk_at_time(QDPattern, BMPattern, lattice_rec.time, -1);
  lattice_rec.brho = BrhoAtTime(BMPattern, lattice_rec.time);
  lattice_rec = calc_lattice(lattice_rec);
  
  if (isfield(lattice_rec, "measured_tune"))
    initv = [lattice_rec.qfk, lattice_rec.qdk];
    if (isfield(lattice_rec, "measured_beta"))
      initv(end+1) = 0;
    endif
    lattice_rec = lattice_with_optim(lattice_rec, "initial", initv);
  endif

endfunction
