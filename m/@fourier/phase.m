## -*- texinfo -*-
## @deftypefn {Function File} {@var{amplitude} =} phase(@var{fourier_obj})
## Return phase which is not unwraped.
## To unwraped phase, use @var{fourier_obj}.phase_unwrap.
## 
## @end deftypefn

function retval = phase(x)
  retval = arg(x.fft_result);
  nsample = length(x.fft_result);
  n_half = floor(nsample/2);
  #retval = retval(1:n_half)/(nsample/2); 
  retval = retval(1:n_half);
endfunction

%!test
%! func_name(x)
