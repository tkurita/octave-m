## usage : fftRec = fourier(fftRec)
##
## = Paramerters
## * fftRec must have following data
##  .data
##  .interval
##
## * result
##  .fftResult
##  .ampllitude
##  .frequency

function fftRec = fourier(fftRec)
  fftResult = fft(fftRec.data);
  nsample = length(fftRec.data);
  amplitude = abs(fft(fftRec.data));
  halfN = floor(nsample/2);
  amplitude = amplitude(1:halfN);
  delf = 1/(fftRec.interval * nsample);
  frequency = 0:delf:((halfN-1)*delf);
  fftRec = appendFields(fftRec, fftResult, amplitude, frequency);
endfunction
