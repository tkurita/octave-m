function varargout = lattice_definition(varargin)
  persistent func_name;
  if (length(varargin) > 0)
    func_name = varargin{1};
  else
    varargout{1} = str2func(func_name);
  endif
endfunction

    