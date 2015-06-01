## -*- texinfo -*-
## @deftypefn {Function File} {@var{dBm} =} dBm_with_vpp(@var{vpp}, @var{r})
## Convert a value in Vpp to to a value in dBm.
## @strong{Inputs}
## @table @var
## @item r
## A load resistance. If ommited, 50 ohm is assumed.
## @end table
##
## @seealso{vpp_with_dBm}
## @end deftypefn

function retval = dBm_with_vpp(vpp, r = 50)
  if ! nargin
    print_usage();
  endif
  vrms = vpp/(2*sqrt(2));
  mw = vrms.^2/r*1e3; # power in mW
  retval = 10*log10(mw);
endfunction

%!test
%! func_name(x)
