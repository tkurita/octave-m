## -*- texinfo -*-
## @deftypefn {Function File} {} beta_with_brho(@var{brho}, @var{particle}, @var{charge})
##
## @end deftypefn

##== History
##

function retval = beta_with_brho(varargin)
  mev = mev_with_brho(varargin{:});
  retval = beta_with_mev(mev, varargin{2});
endfunction

%!test
%! beta_with_brho(x)
