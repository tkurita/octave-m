## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} vrms_with_dBm(@var{dbm}, @var{r})
## Convert a value in dBm to a value in Vrms.
## @strong{Inputs}
## @table @var
## @item dbm
## amplitude in dBm
## @item r
## load resistance in ohm
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## amplitude in Vrms
## @end table
##
## @end deftypefn

function retval = vrms_with_dBm(dbm, r)
  p = 10^(dbm/10); # power in mW
  retval = sqrt(r*p*1e-3);
endfunction

%!test
%! func_name(x)
