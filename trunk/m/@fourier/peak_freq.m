## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} peak_freq(@var{fourier_obj})
## Obtain a frequency of the maximum amplitude.
##
## @end deftypefn

##== History
##

function retval = peak_freq(x)
  [max_amp, i_amp] = max(x.amplitude);
  retval = x.frequency(i_amp);
endfunction

%!test
%! func_name(x)
