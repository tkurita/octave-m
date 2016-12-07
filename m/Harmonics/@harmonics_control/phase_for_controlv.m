## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} func_name(@var{arg})
## description
## @strong{Inputs}
## @table @var
## @item arg1
## description of @var{arg}
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## description of @var{retval}
## @end table
##
## @end deftypefn

function retval = phase_for_controlv(self, phase_ctrlv, f_in_Hz)
  if ! nargin
    print_usage();
    return;
  endif
  phase_base_v = forward_interp(self._properties.ci_phase_base...
                              , f_in_Hz);
  pstable = self._properties.pstable;
  pscurve = pstable.curve_for_Hz(f_in_Hz);
  retval = rad_for_v(pscurve, phase_ctrlv) - rad_for_v(pscurve, phase_base_v);
endfunction

%!test
%! func_name(x)
