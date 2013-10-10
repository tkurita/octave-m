## -*- texinfo -*-
## @deftypefn {Function File} {[@var{P}, @var{N}] =} find_notch_filter_params(@var{fs}, @var{notch_cycle}, @var{n_stage}, @var{ts})
##
## @strong{Inputs}
## @table @var
## @item fs
## sampling frequency [Hz];
## @item notch_cycle
## [Hz] frequency between notches
## @item n_stage
## number of stage of filter. must be 2*m
## @item td
## time delay (sec)
## @end table
##
## @strong{Outputs}
## @table @var
## @item P
## @item N
## @end table
##
## @end deftypefn

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