## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} gain_10dB(@var{arg})
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

function retval = gain_10dB(X, varargin)
  retval = gain(X, varargin{:});
  retval(:,2) = 10*log10(retval(:,2));
endfunction

%!test
%! gain_10dB(x)
