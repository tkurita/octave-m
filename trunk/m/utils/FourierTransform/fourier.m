## -*- texinfo -*-
## @deftypefn {Function File} {@var{fft_rec} =} fourier(@var{fft_rec}, ["plot"])
## @deftypefnx {Function File} {@var{fft_rec} =} fourier(@var{data}, @var{interval}, ["plot"])
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

##== History
## 2014-04-15
## * added "plot" option.
## 2013-11-06
## * accept non structure parameter.
## * make a plot if no output aguments.

function varargout = fourier(varargin)
  if ! nargin
    print_usage();
  endif
  
  arg_index = 2;
  if isstruct(varargin{1})
    fft_rec = varargin{1};
  else
    fft_rec = struct("data", varargin{1}, "interval", varargin{2});
    arg_index = 3;
  endif
  
  fft_result = fft(fft_rec.data);
  nsample = length(fft_rec.data);
  amplitude = abs(fft(fft_rec.data));
  n_half = floor(nsample/2);
  amplitude = amplitude(1:n_half);
  delf = 1/(fft_rec.interval * nsample);
  frequency = 0:delf:((n_half-1)*delf);
  fft_rec = append_fields(fft_rec, fft_result, amplitude, frequency);
  if nargout
    varargout{1} = fft_rec;
    if length(varargin) >= arg_index
      if !contain_str(varargin, "plot")
        return;
      endif
    endif
  endif
  
  plot(frequency, 20*log10(amplitude), "-");...
  set(gca, "xscale", "log");grid on;
  ylabel("magnitude [dBm]");
  xlabel("[Hz]");  
endfunction
