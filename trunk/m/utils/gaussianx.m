## -*- texinfo -*-
## @deftypefn {Function File} {} gaussianx(@var{x}, @var{amp}, @var{sigma}, @var{mu})
## @deftypefnx {Function File} {} gaussianx(@var{x}, [@var{amp}, @var{sigma}, @var{mu}])
##
## Return value of gaussian distribution as @var{x}.
## 
## @var{amp}*exp(-1*(@var{x} - @var{mu}).^2/(2*@var{sigma}^2));
##
## @table @code
## @item @var{amp}
## Amplitude. When 0 is passed, normalized amplitude (1/(@var{sigma}*sqrt(2*pi)) is used.
## @item @var{sigma}
## standard deviation
## @item @var{mu}
## mean
## @end table
## 
## @end deftypefn

##== History
## 2008-12-08
## * Add normalized amplitude mode.
## 2008-07-02
## * rename to gaussianx from gaussian, bcause there is gaussian function in signal package.
##

function result = gaussianx(x, amp, sigma, mu)
  if (nargin < 3)
    sigma = amp(2);
    mu = amp(3);
    amp = amp(1);
  endif
  if (!amp)
    amp = (1/(sigma*sqrt(2*pi)));
  endif
  result = amp.*exp(-1.*(x - mu).^2/(2.*sigma^2));
endfunction

  