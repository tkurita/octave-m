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
## 2012-07-17
## * first implementation

function retval = phase(X, varargin)
  params = X.params;
  if length(varargin)
    params = join_struct(params, varargin{:});
  endif
  a_tf = X.tf;
  if isa(a_tf, "function_handle")
    a_tf = X.tf(params);
  endif
  [m,p,w] = bode(a_tf, 2*pi*X.f_in);
  retval = [w/(2*pi), p];
endfunction

%!test
%! phase(x)
