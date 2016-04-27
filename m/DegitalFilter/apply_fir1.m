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

function retval = apply_fir1(n, fcn, v);
  pkg load signal;
  fir = fir1(n, fcn);
  retval = filter(fir, 1, v);
endfunction

%!test
%! func_name(x)
