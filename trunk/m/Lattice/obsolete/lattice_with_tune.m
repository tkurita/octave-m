## -*- texinfo -*-
## @deftypefn {Function File} {@var{lattice_rec} =} lattice_with_tune(@var{lattice_rec})
## 
## deprecated. Use lattice_with_optim
##
## Calculate lattice with evaluating qfk, qdk to meat 'measured_tune'.
##
## Input @var{lattice_rec} can have following fields.
##
## @table @code
## @item measured_tune.h
## horizontal tune
##
## @item measured_tune.v
## vertical tune
##
## @item measured_beta.qf.h
## horizontal beta function at QF. Optional.
##
## @item measured_beta.qf.v
## vertical beta function at QF. Optional.
##
## @item measured_beta.qd.h
## horizontal beta function at QD. Optional.
##
## @item measured_beta.qd.v
## vertical beta function at QD. Optional.
## @end table
##
## Following fields are appended into output @var{lattice_rec}.
##
## @table @code
## @item lattice
## @item tune
## @item qfk
## [1/(m*m)]. Focusing power is obtained by multiplying effective length.
## @item qdk
## [1/(m*m)]
## @item vedge
## "vedged" is appended, if beta function is in fitting values.
## @end table
##
## @seealso{calc_lattice, lattice_with_time_tune}
##
## @end deftypefn

##= History
## 2008-07-25
## * beta function のサポートを help に書いた
## 
## 2007-10-18
## * renamed from calcLatticeForTune
##
## 2006.10.12
## * calcLatticeSimple ではなく、calcWERCLattice を使うように変更
##
## 2006.09.28
## * vedge の値を 0にした。

function lattice_rec = lattice_with_tune(lattice_rec, varargin)
  warning("lattice_with_tune is obsolete. Use lattice_wtih_optim.");
  lattice_rec = search_qk(lattice_rec, varargin{:});
  lattice_rec = calc_lattice(lattice_rec);
endfunction
