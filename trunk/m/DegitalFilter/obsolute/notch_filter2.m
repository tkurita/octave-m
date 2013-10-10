## usage : result = notch_filter(P, N, m, data)
##         result = notch_filter(filter_rec, data)
##
##  trasfer function : {1 - z^(-N) / (1- z^(-P))}^m
##
## fields of filter_rec 
##  .P
##  .N
##  .m

function data = notch_filter2(varargin)
  warning("notch_filter2 is deprecated. Use mcic_filter.");
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
  
#  for k = 1:P
#    data(k) += data(end-(P-k));
#  endfor
  
  data = data/Q;
  if --m > 0 
    data = notch_filter2(P, N, m, data);
  endif
  
endfunction
