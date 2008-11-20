## -*- texinfo -*-
## @deftypefn {Function File} {@var{lattice_rec} =} lattice_with_time(@var{lattice_rec})
##
## Calculate lattice at time spedified with 'time' field of @var{lattice_rec}.
## 
## @var{lattice_rec} can have following fields
##
## @table @code
## @item time
## time [msec] in Magnet pattern. brho is obtained from function 'BMPattern' at 'time'
##
## @item brho
## [T*m]. If ommited, the value is evaluated using the function BMPattern.
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
## @seealso{lattice_with_tune}
## @end deftypefn

##== History
## 2008-07-24
## * use lattice_with_tune instead of calcLatticeForTune

function lattice_rec = lattice_with_time(lattice_rec, varargin)
  # lattice_rec = lat_rec_FT
  if (!isfield(lattice_rec, "brho"))
    brho_def = BrhoAtTime(BMPattern, lattice_rec.time);
    lattice_rec.brho = (get_properties(varargin, {"brho"}, {brho_def})).brho;
  endif
  lattice_rec.qfk = qk_at_time(QFPattern, lattice_rec.brho, lattice_rec.time);
  lattice_rec.qdk = qk_at_time(QDPattern, lattice_rec.brho, lattice_rec.time, -1);
  
  lattice_rec = calc_lattice(lattice_rec);
  
  if (isfield(lattice_rec, "measured_tune"))
    lattice_rec.initial_qfk = lattice_rec.qfk;
    lattice_rec.initial_qdk = lattice_rec.qdk;
    lattice_rec = lattice_with_tune(lattice_rec);
  endif

endfunction
