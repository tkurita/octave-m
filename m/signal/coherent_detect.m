## -*- texinfo -*-
## @deftypefn {Function File} {[@var{amp}, @var{phase}] =} coherent_detect(@var{x}, @var{fc})
## coherent detection
## @strong{Inputs}
## @table @var
## @item x
## time series data
## @item fc
## carrier frequency. should be normalized with sampling frequency in Hz.
## @end table
##
## @strong{Outputs}
## @table @var
## @item amp
## 2*sart(I^2 + Q^2)
## @item phase
## atan(Q/I)
## @end table
##
## @end deftypefn

function varargout = coherent_detect(x, fc)
  if ! nargin
    print_usage();
  endif
  t = (0:length(x)-1)';
  x = x(:);
  multi_sin = x.*sin(2*pi*fc*t);
  multi_cos = x.*cos(2*pi*fc*t);
  
  # moving average + hamming
  nfo = round(2/fc); # filter order
  maf1 = ones(nfo,1)./nfo;
  maf2 = normalize_filter(hamming(nfo).*maf1, 0);
  Iout = filter(maf2, 1, multi_sin);
  Qout = filter(maf2, 1, multi_cos);
  amp = 2*sqrt(Iout.^2 + Qout.^2);
  if mean(abs(Qout)) > mean(abs(Iout)) # I が 0 付近だと、Q/I が発散する。
    phase = acos(Iout./(amp/2));
  else
    phase = atan(Qout./Iout);
  endif
  
  switch nargout
    case 1
      varargout = {struct("amp", amp, "phase" ,phase, "I", Iout, "Q", Qout)};
    case 2
      varargout = {amp, phase};
  endswitch
endfunction

# 

%!test
%! func_name(x)
