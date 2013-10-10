## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} notch_mcic_filter(@var{P}, @var{N}, @var{m}, @var{data})
## @deftypefnx {Function File} {@var{retval} =} notch_mcic_filter(@var{filter_rec}, @var{data})
##
## Apply a multiple notch filter using modified CIC to @var{data}.
## 
## @verbatim
##   z^(-P*(m/2)*(Q-1)) - {1 - z^(-N) / (1- z^(-P))}^m 
##      Q = N/P
## @end verbatim
## 
## @strong{Inputs}
## @table @var
## @item P
## Give interval of notches. Should be round(fn/fs). 
## fn : interval of notch in Hz, fs : sampling frequency in Hz.
## @item N
## Must be a multiple of @var{P}.
## @item m
## Must be an even number.
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## Filtered value of @var{data}.
## @end table
##
## @seealso{mcic_filter, notch_freqz}
##
## @end deftypefn

##== History
## 2013-10-10
## * first implementation

function retval = notch_mcic_filter(varargin)
  data = NA;
  if (isstruct(varargin{1}))
    P = varargin{1}.P;
    N = varargin{1}.N;
    m = varargin{1}.m;
    if nargin > 1
      data = varargin{2}(:);
    endif
  else
    P = varargin{1};
    N = varargin{2};
    m = varargin{3};
    if nargin > 3
      data = varargin{4}(:);
    endif
  endif
  
  if isna(data)
    error("No data given.");
  endif
  
  for n = 1:m
    data2 = _notch_filter(P, N, data);
  endfor

  Q = N/P;
  
  retval = shift(data, P*(m/2)*(Q-1)) - data2;
endfunction

function data = _notch_filter(P, N, data)
  Q = N/P;
  data = data(:);

  # com filter
  shifted_data = shift(data,N);
  shifted_data(1:N,:) = 0;
  data = data - shifted_data;
 
  # integrator
  lendata = length(data);
  for k = (P+1):lendata
    data(k) += data(k - P);
  endfor
  
  data = data/Q;
endfunction