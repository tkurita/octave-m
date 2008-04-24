## -*- texinfo -*-
## @deftypefn {Function File} {} itobl_definition(@var{func_name})
## @deftypefn {Function File} {@var{func_handle}} itobl_definition()
##
## Set a function name which provides conversion functors from current value to BL value.
## 
## If called without arguments, return a funciton handle whose name is previously set.
## 
## @end deftypefn

##== History
## 2008-04-24
## * initial implementaion

function varargout = itobl_definition(varargin)
  persistent func_name;
   if (length(varargin) > 0)
    func_name = varargin{1};
    eval(["clear ", func_name]);
  else
    if isempty(func_name)
      error("No function is given to itol_definition.");
    end
    varargout{1} = str2func(func_name);
  endif
endfunction