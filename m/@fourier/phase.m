## -*- texinfo -*-
## @deftypefn {Function File} {@var{amplitude} =} phase(@var{fourier_obj})
## return phase
## @end deftypefn

function retval = phase(x)
  retval = unwrap(arg(x.fft_result));
  nsample = length(x.fft_result);
  n_half = floor(nsample/2);
  #retval = retval(1:n_half)/(nsample/2); 
  retval = retval(1:n_half);
endfunction

%!test
%! func_name(x)
