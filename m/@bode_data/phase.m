## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} phase(@var{arg})
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

##== History
## 2012-08-08
## * bode_data.tf is allowed function name.
## 2012-07-17
## * first implementation

function retval = phase(X, varargin)
  params = X.params;
  if length(varargin)
    params = join_struct(params, varargin{:});
  endif
  a_tf = X.tf;
  if isa(a_tf, "function_handle") || isa(a_tf, "char")
    a_tf = feval(a_tf, params);
  endif
  [m,p,w] = bode(a_tf, 2*pi*X.f_in);
  retval = [w/(2*pi), p];
endfunction

%!test
%! phase(x)
