## Usage : result = gaussian(x, amp, sigma, mu)

function result = gaussian(x, amp, sigma, mu)
  if (nargin < 3)
    sigma = amp(2);
    mu = amp(3);
    amp = amp(1);
  endif
  
  result = amp*exp(-1*(x - mu).^2/(2*sigma^2));
endfunction

  