## -*- texinfo -*-
## @deftypefn {Function File} {@var{yt} =} inv_real(@var{fourier_obj})
## Calculate invert fourier transformer without using imaginaly numbers.
## In ordicary cases ifft should be used ,because this routuine is slow. 
## @seealso{inv}
## @end deftypefn

## $Date::                           $
## $Rev$
## $Author$

##== History
## 2015-02-25
## * return [t, y] matrix.
## 2015-02-16
## * first implementation

function yt = inv_real(x)
  bs = x.fft_result(:); # standardize as a column-wise vector
  ns = length(bs);
  # if ns is odd
  smax = (ns + 1)/2;
  eventerm = @(n) 0;
  if mod(ns, 2) == 0 # even
    smax = ns/2;
    eventerm = @(n) abs(bs(ns/2+1))*cos(pi*(n-1)+arg(bs(ns/2+1)));
  endif
  bs_abs = abs(bs(2:smax));
  bs_arg = arg(bs(2:smax));
  s = (1:(smax-1))'; # standardize as a column-wise vector
  st = time;
  for n = 1:ns
    y(n) = eventerm(n) + 2*sum(bs_abs.*cos(2*pi*(n-1).*s/ns .+ bs_arg));
    printf("%d/%d, elapsed time : %.1f [s]\r", n, ns, time()-st);
  endfor
  printf("\n"); # prevent overlap between the display of the elapsed time 
                # and a prompt.
  y = (bs(1) + y)/ns;
  t = linspace(0, 1/x.df, length(y));
  yt = [t(:), y(:)];
endfunction