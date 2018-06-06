## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} set_frequency(@var{arg})
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
## * first implemantaion

function X = set_frequency(X, f_in)
  X.f_in = f_in;
  X.response = NA;
  X = frequency_response(X);
endfunction

%!test
%! set_frequency(x)
