## -*- texinfo -*-
## @deftypefn {Function File} {@var{amplitude} =} amp(@var{fourier_obj})
## return amplitude
## @end deftypefn

##== History
## 2015-02-05
## * first implementation

function retval = amp(x)
  retval = abs(x.fft_result);
  nsample = length(x.fft_result);
  n_half = floor(nsample/2);
  #retval = retval(1:n_half)/(nsample/2); 
  retval = retval(1:n_half)/(nsample); 
endfunction

%!test
%! func_name(x)
