## fs : sampling frequency [Hz];
## notch_cycle : [Hz] frequency between notches
## n_sgate : number of stage of filter. must be 2*m
## td : time delay (sec)
## --ds : time delay (number of sampling)
function [P,N] = find_notch_filter_params(fs, notch_cycle, n_stage, ts)
  if (mod(fs, notch_cycle) != 0) 
    error "fs/notch_cycle must be integer.";
  endif
  # fs=100
  # notch_cycle = 50
  # ts = 2
  # n_stage = 2
  P = fs/notch_cycle;
  ds = ts*fs;
  N = 2*ds/n_stage + P;
endfunction