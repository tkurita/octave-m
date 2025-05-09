## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} vpp_with_dBm(@var{dbm}, @var{r})
## Convert a value in dBm to a value in Vpp.
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

function retval = vpp_with_dBm(dbm, r)
  if nargin < 2
    print_usage();
    return;
  endif
  retval=2*sqrt(2)*vrms_with_dBm(dbm, r);
endfunction

%!test
%! func_name(x)
