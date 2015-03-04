## usage : dw = notch_width(P, N, m, amp)
##    calculate notch band width of notch filter
##
## frequency caracterictics of notch filter is given following 
## equation. The maxmum gain is normalized to 1.
##    f(w) = ((1/Q) * sin(N*w/2)/sin(P*w/2))^m
## * P : integer
## * N : integer
## * m : integer, number of stages
## * amp : 0 < amp < 1
## * w: normalized angle velocity 0 < w < pi
##
## P and N must have following relationship.
##    N = PQ : Q is integer
##
## the result of dw is given by
##    f(dw) = amp
## ±dw is band width.
## dw is normalized angle velocity

function dw = notch_width(P, N, m, amp)
  result = cic_solve(P, N, m, amp);
  [hdw, INFO, MSG] = fsolve ("cic_solve", 0.0001)
  dw = hdw;
endfunction

## when multiple arguments given, setup parameters
function result = cic_solve(varargin)
  persistent P;
  persistent N;
  persistent m;
  persistent amp;
  persistent Q;
  if length(varargin) > 1
    #"setup"
    P = varargin{1};
    N = varargin{2};
    m = varargin{3};
    amp = varargin{4};
    Q = N/P;
    result = 1;
    return;
  else
    w = varargin{1};
  endif
#  P
#  N
#  m
#  amp
#  Q
  result = ((1/Q) * sin(N*w/2)/sin(P*w/2))^m - amp;
endfunction
