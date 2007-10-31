## -*- texinfo -*-
## @deftypefn {Function File} {@var{lattice_rec} =} calc_lattice(@var{lattice_rec})
##
## @deftypefnx {Function File} {@var{lattice_rec} =} calc_lattice(@var{qfk}, @var{qdf}, [@var{vedge}])
##
## Return evaluated lattice and tune with given Q values.
## The lattice definition is given by function 'lattice_definition'
##
## Parameters
##
## @table @code
## @item qfk
## [1/(m*m)]
##
## @item qdk
## [1/(m*m)]
##
## @item vedge
## optional
## @end table
##
## Results
##
## @table @code
## @item lattice
## a cell array
## @item tune
## a structure. Fields 'h' and 'v' are horizontal and vertical tune respectively.
## @end table
##
## @seealso{lattice_definition, process_lattice, lattice_with_tune, lattice_with_time_tune}
## @end deftypefn

##== History
## 2007-10-18
## * defiverd from calcWERCLattice

function lattice_rec = calc_lattice(varargin)
  # varargin = {lattice_rec};
  if (isstruct(varargin{1}))
    lattice_rec = varargin{1};
  else
    lattice_rec = struct("qfk", varargin{1}, "qdk", varargin{2});
    if (length(varargin) > 2)
      lattice_rec.vedge = varargin{3};
    endif
  endif
  
  lattice_def = lattice_definition();
  lattice_rec.lattice = lattice_def(lattice_rec);
  lattice_rec = process_lattice(lattice_rec);
endfunction
