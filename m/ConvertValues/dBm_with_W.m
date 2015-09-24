## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} dBm_with_W(@var{watt})
## Convert a value in W to to a value in dBm.
##
## @seealso{Vpp_with_W}
## @end deftypefn

function retval = dBm_with_W(watt)
  if ! nargin
    print_usage();
  endif
  retval = 10*log10(watt*1000);
endfunction

%!test
%! func_name(x)
