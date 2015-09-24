## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} Vpp_with_W(@var{watt})
## Convert a value in W to to a value in Vpp.
##
## @seealso{Vpp_with_W}
## @end deftypefn

function retval = Vpp_with_W(watt, r)
  if ! nargin
    print_usage();
  endif
  retval = 2*sqrt(2*r*watt);
endfunction

%!test
%! func_name(x)
