## -*- texinfo -*-
## @deftypefn {Function File} {@var{tune_frac} =} tune_with_fft(@var{mat})
##
## The argument @var{mat} is a particle history of one particle. 
## Return tune's fractional part with FFT.
##
## The first column of @var{mat} is considered for calculation of tunes.
## 
## @example
##  a_hist = distill_history(particle_hist, "ESD");
##  tune_frac = tune_with_fft(a_hist.h@{1@});
## @end example
## @end deftypefn

function tune_frac = tune_with_fft(mat)
  # mat = a_hist.h{1}
  f_result = fourier(struct("data", mat(:,1), "interval", 1));
  #plot(f_result.frequency, f_result.amplitude);
  [max_amp, ind_max] = max(f_result.amplitude);
  tune_frac = f_result.frequency(ind_max);
endfunction