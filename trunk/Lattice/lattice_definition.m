## -*- texinfo -*-
## @deftypefn {Function File} {} lattice_definition(@var{func_name})
## @deftypefnx {Function File} {@var{func_handle} =} lattice_definition()
## 
## Set a function name which provides a lattice definition.
##
## If called without arguemnts, return a function handle whose name is previously set.
##
## @seealso{calc_lattice, lattice_with_tune, lattice_with_time_tune}
## @end deftypefn

function varargout = lattice_definition(varargin)
  persistent func_name;
  if (length(varargin) > 0)
    func_name = varargin{1};
  else
    varargout{1} = str2func(func_name);
  endif
endfunction

    