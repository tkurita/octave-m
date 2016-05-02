## -*- texinfo -*-
## @deftypefn {Function File} {@var{[f, a, idx]} =} peak_freq(@var{fourier_obj})
## Obtain a frequency of the maximum amplitude.
##
## @strong{Outputs}
## @table @var
## @item f
## frequency of the peak.
## @item a
## amplitude of @var{f}.
## @item idx
## index of peak frquency
## @end table
## 
## @seealso{}
## @end deftypefn

function [f, a, idx] = peak_freq(x)
  [max_amp, idx] = max(amp(x));
  f = x.frequency(idx);
  a = max_amp;
endfunction

%!test
%! func_name(x)
