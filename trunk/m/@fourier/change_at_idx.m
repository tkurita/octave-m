## -*- texinfo -*-
## @deftypefn {Function File} {@var{fourier_obj} =} change_at_idx(@var{fourier_obj}, @var{idx}, @var{b})
## Change fourier coefficients of index @var{idx} (1 based) to @var{b}.
## @var{idx} must be less than < N/2.
## The fourier cofficients of index (N -@var{idx}+2} is also set to @var{b}.
## 
## @end deftypefn

## $Date::                           $
## $Rev$
## $Author$

##== History
## 2015-02-25
## * first implementation

function x = change_at_idx(x, idx, b)
  ns = length(x.fft_result);
  x.fft_result(idx) = b;
  x.fft_result(ns -idx + 2) = b;
endfunction

%!test
%! func_name(x)
