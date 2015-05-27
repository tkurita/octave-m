## -*- texinfo -*-
## @deftypefn {Function File} {@var{amplitude} =} amp(@var{fourier_obj})
## return amplitude
## @end deftypefn

function retval = amp(x)
  nsample = length(x.fft_result);
  n_half = floor(nsample/2);
  # 複素数表示のフーリエ係数から振幅を求めるときは 2倍する必要がある。
  # /Users/tkurita/Dropbox/Study/Mathematical Basic/フーリエ変換/FourierTransformer.pdf
  retval = 2*abs(x.fft_result(1:n_half)/nsample);
endfunction

%!test
%! func_name(x)
