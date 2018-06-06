## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} func_name(@var{arg})
## description
## @strong{Inputs}
## @table @var
## @item arg1
## description of @var{arg}
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## description of @var{retval}
## @end table
##
## @end deftypefn

function [a_tf, params] = eval_tf(X, varargin)
  params = X.params;
  if length(varargin)
    params = join_struct(params, varargin{:});
  endif
  a_tf = X.tf;
  if isa(a_tf, "function_handle") || isa(a_tf, "char")
    a_tf = feval(a_tf, params);
  endif
endfunction

%!test
%! func_name(x)
