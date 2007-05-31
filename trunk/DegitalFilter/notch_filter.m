## usage : result = notch_filter(P, N, m, data)
##         result = notch_filter(filter_rec, data)
##
## fields of filter_rec 
##  .P
##  .N
##  .m

function data = notch_filter(varargin)
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
  data = data - shift(data, N);
  
  lendata = length(data);
  for k = (P+1):lendata
    data(k) += data(k - P);
  endfor
  
  for k = 1:P
    data(k) += data(end-(P-k));
  endfor
  
  data = data/Q;
  if --m > 0 
    data = notch_filter(P, N, m, data);
  endif
  
endfunction
