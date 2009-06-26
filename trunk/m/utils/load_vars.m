## -*- texinfo -*-
## @deftypefn {Function File} {[@var{v1}, @var{v2},.. =} load_vars(@var{file},{"v1", "v2",...}, @var{opts})
##
## Load specifeid varables from data file and return as results.
## 
##
## @end deftypefn

##== History
## 2009-06-26
## * first implementation

function varargout = load_vars(varargin)
  if nargin < 1
    print_usage();
  endif
  pre_varnames = who("-variables");
  load(varargin{1});
  varnames = who("-variables");
  pre_varnames{end+1} = "pre_varnames";
  varnames = setdiff(varnames, pre_varnames);
  no = nargout;
  if !no
    varnames
    return;
  endif
  
  if length(varargin) > 1
    vnames = varargin{2};
  else
    vnames = varnames;
  endif
  
  for n = 1:length(vnames)
    if n > nargout
      break;
    endif
    varargout{n} = eval(vnames{n});
  endfor
  
endfunction

%!test
%! load_vars(x)
