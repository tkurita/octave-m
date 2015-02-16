## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} fourier_interp(@var{fourier_obj})
## Calculate interpolation using invert fourier transformer.
## @end deftypefn

##== History
## 2015-02-16
## * first implementation

function y = fourier_interp(x, t)
  bs = x.fft_result;
  ns = length(bs);
  # if ns is odd
  smax = (ns + 1)/2;
  eventerm = @(n) 0;
  if mod(ns, 2) == 0 # even
    smax = ns/2;
    eventerm = @(tn) abs(bs(ns/2+1))*cos(pi*tn*ns +arg(bs(ns/2+1)));
  endif
  bs_abs = abs(bs(2:smax));
  bs_arg = arg(bs(2:smax));
  s = 1:(smax-1);
  
  tn = t * x.df; # nomilized time
  for k = 1:length(tn);
    tnk = tn(k);
    y(k) = eventerm(tnk) + 2*sum(bs_abs.*cos(2*pi*tnk.*s + bs_arg));
  endfor
  y = (bs(1) + y)/ns;
endfunction