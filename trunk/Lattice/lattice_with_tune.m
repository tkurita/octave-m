## -*- texinfo -*-
## @deftypefn {Function File} {@var{lattice_rec} =} lattice_with_tune(@var{lattice_rec})
## 
## Calculate lattice with evaluating qfk, qdk to mead 'measured_tune'.
##
## Input @var{lattice_rec} must have following fields.
##
## @table @code
## @item measured_tune.h
## horizontal tune
##
## @item measured_tune.v
## vertical tune
## @end table
##
## Following fields are appended into output @var{lattice_rec}.
## @table @code
## @item lattice
## @item tune
## @item qfk
## [1/(m*m)]. Focusing power is obtained by multiplying effective length.
## @item qdk
## [1/(m*m)]
## @end table
##
## @seealso{calc_lattice, lattice_with_time_tune}
##
## @end deftypefn

##= History
## 2007-10-18
## * renamed from calcLatticeForTune
## 2006.10.12
## * calcLatticeSimple ではなく、calcWERCLattice を使うように変更
## 2006.09.28
## * vedge の値を 0にした。

function lattice_rec = lattice_with_tune(lattice_rec)
  lattice_rec = search_qk(lattice_rec);
  lattice_rec = calc_lattice(lattice_rec);
endfunction
