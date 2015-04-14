## -*- texinfo -*-
## @deftypefn {Function File} {@var{[f, a]} =} peak_freq(@var{fourier_obj})
## Obtain a frequency of the maximum amplitude.
##
## @strong{Outputs}
## @table @var
## @item f
## frequency of the peak.
## @item a
## amplitude of @var{f}.
## @end table
## 
## @seealso{}
## @end deftypefn

## @end deftypefn

##== History
## 2015-04-14
## return amplitude.

function [f, a] = peak_freq(x)
  [max_amp, i_amp] = max(amp(x));
  f = x.frequency(i_amp);
  a = max_amp;
endfunction

%!test
%! func_name(x)
