## -*- texinfo -*-
## @deftypefn {Function File} {} pickup(@var{matfile}, @var{varname1}, @var{varname2}, ...)
## 
## Pick up @var{varname} in @var{matfile}
## 
## @end deftypefn

##== History
## 2008-08-08
## * first implementaion

function varargout = pickup(matfile, varargin)
  varargout = {};
  if (length(varargin))
    load(matfile, varargin{:});
  else
    load(matfile);
    varargin = {strip_suffix(basename(matfile))};
  endif
  for n = 1: length(varargin)
    varname = varargin{n};
    varargout{end+1} = eval(varname);
  endfor
endfunction

%!test
%! pickup(x)
