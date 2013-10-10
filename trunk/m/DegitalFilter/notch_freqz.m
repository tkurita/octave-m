## -*- texinfo -*-
## @deftypefn {Function File} {@var{h} =} notch_freqz(@var{p}, @var{n}, @var{m}, @var{fn})
## Obtain frequency response of notch filter using a modified CIC filter.
##
## @verbatim
##   z^(-P*(m/2)*(Q-1)) - {(1 - z^(-N)) / (1- z^(-P))}^m 
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
## @item fn
## Normalized frequency with sampling frequency.
## Must be 0 - 0.5.
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## description of @var{retval}
## @end table
##
## @end deftypefn

##== History
## 2013-10-10
## * first implementation

function h = notch_freqz(varargin)
  fn = NA;
  if (isstruct(varargin{1}))
    P = varargin{1}.P;
    N = varargin{1}.N;
    m = varargin{1}.m;
    if nargin > 1
      fn = varargin{2}(:);
    endif
  else
    P = varargin{1};
    N = varargin{2};
    m = varargin{3};
    if nargin > 3
      fn = varargin{4}(:);
    endif
  endif
  
  if isna(fn)
    error("No target frequency is given.");
  endif
  Q = N/P;
  w = 2*pi*fn;
  h = exp(-j*w*P*(m/2)*(Q-1)) - (1/Q^m).*((1 - exp(-j*w*N))./ (1- exp(-j*w*P))).^m;
endfunction

%!test
%! func_name(x)
