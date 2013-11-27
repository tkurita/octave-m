## usage : y = inv_fourier(fftRec [, time] )
## invert fft
## calculate any time points
## * fftRec -- output of fourier
## * time -- time to calculate y, the unit is depend of fftRec.
##
## 遅すぎて使えない。
## ifft を使おう

function y = inv_fourier(fftRec, varargin)
  bs = fftRec.fft_result;
  N = length(bs);
  if (mod(N, 2) == 0)
    maxs = N/2+1;
  else
    maxs = (N-1)/2;
  endif
  
  if (length(varargin) > 0)
    time = varargin{1}/(fftRec.interval*N);
  else
    time = (0:N-1)/N;
  endif
  s = 1:N;
  ind = 1;
  for t = time
    y(ind++) = (real(bs(1)) \
    + sum(abs(bs(2:maxs)) \
             .*cos(2*pi*(s(2:maxs)'-1)*t \
                      + arg(bs(2:maxs)) )) \
    + sum(abs(bs(maxs+1:N)) \
             .*cos(2*pi*(N-s(maxs+1:N)'+1)*t \
                      - arg(bs(maxs+1:N)) )) \
    )/N;
  endfor
  
endfunction