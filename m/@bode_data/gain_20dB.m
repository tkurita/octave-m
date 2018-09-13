## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} gain_20dB(@var{arg})
## return [f, 20*log10(gain)] .
##
## @strong{Outputs}
## @table @var
## @item retval
## a matrix of [f, gain]
## @end table
##
## @end deftypefn

function retval = gain_20dB(X, varargin)
  retval = gain(X, varargin{:});
  retval(:,2) = 20*log10(retval(:,2));
endfunction

%!test
%! gain_20dB(x)
