## -*- texinfo -*-
## @deftypefn {Function File} {@var{fft_rec} =} fourier(@var{fft_rec}, [opts,...])
## @deftypefnx {Function File} {@var{fft_rec} =} fourier(@var{data}, [opts,...])
## @deftypefnx {Function File} {@var{fft_rec} =} fourier(@var{xy}, [opts,...])
## @deftypefnx {Function File} {@var{fft_rec} =} fourier(... , ["window", wf],  ["plot", @var{plotopts},...])
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
##
## If @var{xy} is given, y value is resampled with mean iterval of x value.
##
## @end deftypefn

##== History
## 2015-04-09
## * improved parameter handling.
## * added support a window function.
## 2015-02-13
## * The number of sampling data "ns" is appended into a result structure.
## 2014-11-26
## * accept xy data.
## 2014-11-21
## * if a structre is not passed, data and interval field of the returned value 
##   will be empty to save memory.
## 2014-11-17
## * moved to class
## 2014-11-13
## * added support of plot options 
## 2014-04-23
## * amplitude is normalized.
## 2014-04-15
## * added "plot" option.
## 2013-11-06
## * accept non structure parameter.
## * make a plot if no output aguments.

function varargout = fourier(varargin)
  if ! nargin
    print_usage();
  endif
  arg_idx = 2;
  if isstruct(varargin{1})
    fft_rec = varargin{1};
    y = fft_rec.data;
    ts = fft_rec.interval;
  elseif columns(varargin{1}) == 2
    t = varargin{1}(:,1);
    ti = linspace(t(1), t(end), length(t))';
    y = interp1(t, varargin{1}(:,2), ti);
    ts = mean(diff(ti));
    fft_rec = struct("data", [], "interval", []);
  else
    #fft_rec = struct("data", varargin{1}, "interval", varargin{2});
    fft_rec = struct("data", [], "interval", []);
    y = varargin{1};
    ts = varargin{2};
    arg_idx = 3;
  endif
  
  do_plot = false;
  plot_opts = {};
  while arg_idx <= length(varargin)
    opt = varargin{arg_idx};
    switch opt
      case "window"
        wf = varargin{++arg_idx};
        if !isempty(wf)
          wf = feval(wf, length(y));
          y = y .* wf;
        endif
      case "plot"
        do_plot = true;
        if length(varargin) > arg_idx
          plot_opts = varargin(arg_idx+1:end);
        endif
      otherwise
        error([opt, " is unknown option."]);
      endswitch
      arg_idx += 1;
  endwhile
  fft_result = fft(y);
  ns = length(y);
  n_half = floor(ns/2);
  df = 1/(ts * ns);
  frequency = 0:df:((n_half-1)*df);
  fft_rec = append_fields(fft_rec, fft_result, frequency, df, ns);
  fft_rec = class(fft_rec, "fourier");
  if nargout
    varargout{1} = fft_rec;
    if !do_plot
      return
    endif
  endif
  
  plot(frequency, 20*log10(amp(fft_rec)), "-", plot_opts{:});...
  set(gca, "xscale", "log");grid on;...
  ylabel("magnitude [dB]");xlabel("[Hz]");
endfunction