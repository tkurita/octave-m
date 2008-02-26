## -*- texinfo -*-
## @deftypefn {Function File} {@var{fft_rec} =} fourier(@var{fft_rec})
## 
## The input @var{fft_rec} is a structure which has following fields
## @table @code
## @item data
## one dimendional matrix
## @item interval
## time interval between data points [sec]
## @end table
##
## The following field added into @var{fft_rec} as output.
## @table @code
## @item fft_result
## output of fft function
## @item amplitude
## abs(fft_result)
## @item frequency
## frequency according to the amplitude
## @end table
## @end deftypefn

function fft_rec = fourier(fft_rec)
  fft_result = fft(fft_rec.data);
  nsample = length(fft_rec.data);
  amplitude = abs(fft(fft_rec.data));
  n_half = floor(nsample/2);
  amplitude = amplitude(1:n_half);
  delf = 1/(fft_rec.interval * nsample);
  frequency = 0:delf:((n_half-1)*delf);
  fft_rec = append_fields(fft_rec, fft_result, amplitude, frequency);
endfunction
