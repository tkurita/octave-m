## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} make_fir(@var{N}, @var{fc}, @var{ftype})
## make a FIR LPF or a FIT HPF. The result can be passed to filter or freqz function.
## @strong{Inputs}
## @table @var
## @item N
## order of the filder
## @item fc
## cutoff frequency
## @item ftype
## filter type. "low" : LPF or "high" : HPF.
## @end table
##
## @end deftypefn

##== History
## 2014-11-12
## * fixed : filter oreder N+1 -> N.
## 2014-11-11
## * help description added.

function varargout = make_fir(N, fc, ftype)
  # fc : normalized frequency with sampling frequency
  if ! nargin
    print_usage();
  endif
  
  switch ftype
    case "high"
      wc = pi *(1 - 2*fc);
    otherwise # LPF
    wc = 2*pi*fc;
  endswitch
  n = 0:(N-1);
  h = (wc/pi)*sinc(n*wc./pi);
  switch ftype
    case "high"
      h = (-1).^n.*h;
  endswitch
  varargout{end+1} = h;
endfunction

%!test
%! func_name(x)
