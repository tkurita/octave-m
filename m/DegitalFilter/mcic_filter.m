## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} mcic_filter(@var{P}, @var{N}, @var{m}, @var{data})
## @deftypefnx {Function File} {@var{retval} =} mcic_filter(@var{filter_rec} @var{data})
##
## Apply a (modified) CIC filter to @var{data}.
##
## @verbatim
##   {(1 - z^(-N)) / (1- z^(-P))}^m 
##      Q = N/P
## @end verbatim
## 
## @strong{Inputs}
## @table @var
## @item P
## For normal CIC filter, must be 1.@*
## For modified CIC filter, should be round(fn/fs). @*
## fn : interval of peaks in Hz. @*
## fs : sampling frequency in Hz.
## @item N
## For normal CIC filter, shoud be round(fn/fs). @*
## fn : interval of notches in Hz. @*
## fs : sampling frequency in Hz. @*
## For modified CIC filter, must be a multiple of @var{P}.
## @item m
## number of stages of mcic filter.
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## Filtered value of @var{data}.
## @end table
## 
## @seealso{notch_mcic_filter, freqz_notch}
## @end deftypefn

##== History
## 2013-10-09
## * renamed from notch_filter2

function data = mcic_filter(varargin)
  if (isstruct(varargin{1}))
    P = varargin{1}.P;
    N = varargin{1}.N;
    m = varargin{1}.m;
  else
    P = varargin{1};
    N = varargin{2};
    m = varargin{3};
  endif
  
  Q = N/P;
  data = varargin{end};
  #N=64.
  #data = ones(1000, 1) .*1;
  #P=8
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
  if --m > 0 
    data = notch_filter2(P, N, m, data);
  endif
  
endfunction
