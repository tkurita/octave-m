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

  [a_ft, params] = eval_tf(X, varargin{:});
  X = frequency_response(X);

  p = unwrap(arg(X.response))*180/pi;
  retval = [X.f_in(:), p(:)];
endfunction

%!test
%! phase(x)
