## -*- texinfo -*-
## @deftypefn {Function File} {@var{xy} =} gain(@var{bode_data} [,@var{pname}, @var{value}])
## 
## calculate gain of the transfer function
##
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
## 2012-07-14
## * initial implementation

function retval = gain(X, varargin)
  params = X.params;
  if length(varargin)
    params = join_struct(params, varargin{:});
  endif
  a_tf = X.tf;
  if isa(a_tf, "function_handle")
    a_tf = X.tf(params);
  endif
  [m,p,w] = bode(a_tf, 2*pi*X.f_in);
  retval = [w/(2*pi), m];
endfunction

%!test
%! gain(x)
