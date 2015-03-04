## -*- texinfo -*-
## @deftypefn {Function File} {@var{yt} =} inv(@var{fourier_obj})
## Evaluate inverse fourier transformer using ifft.
## @*
## The result is two column matrix of [t, y].
## @end deftypefn

## $Date::                           $
## $Rev$
## $Author: tkurita $

function yt = inv(x)
  y = ifft(x.fft_result);
  t = linspace(0, 1/x.df, length(y));
  yt = [t(:), y(:)];
endfunction