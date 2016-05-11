## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} apply_fir1(@var{n}, @var{fcn}, @var{v})
## make a fir filter using @var{n} and @var{fcn} and appy it to @var{v}.
## @strong{Inputs}
## @table @var
## @item n
## filter order
## @item fcn
## normalized cut off frequency in pi rad/sample.
## 2*ts*fc , fc [Hz]
## @item v
## values to apply filter. 
## @end table
##
## @end deftypefn

function varargout = apply_fir1(n, fcn, v, varargin);
  pkg load signal;
  opts = get_properties(varargin, {"delay_correction", false});
  fir = fir1(n, fcn);
  v = filter(fir, 1, v);
  if opts.delay_correction
    gd = round(mean(grpdelay(fir,1, length(fir))));
    v = v(gd+1:end);
  else
    gd = NA;
  endif
  if nargout > 1
    varargout = {v, gd};
  else
    varargout = {v};
  endif
endfunction

%!test
%! func_name(x)
