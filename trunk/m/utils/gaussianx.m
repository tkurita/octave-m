## -*- texinfo -*-
## @deftypefn {Function File} {} gaussianx(@var{x}, @var{amp}, @var{sigma}, @var{mu})
## @deftypefnx {Function File} {} gaussianx(@var{x}, [@var{amp}, @var{sigma}, @var{mu}])
##
## @end deftypefn

##== History
## 2008-07-02
## * rename to gaussianx from gaussian, bcause there is gaussian function in signal package.
##

function result = gaussianx(x, amp, sigma, mu)
  if (nargin < 3)
    sigma = amp(2);
    mu = amp(3);
    amp = amp(1);
  endif
  
  result = amp*exp(-1*(x - mu).^2/(2*sigma^2));
endfunction

  