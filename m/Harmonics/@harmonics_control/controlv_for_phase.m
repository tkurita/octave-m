## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} controlv_for_phase(@var{harm_ctrl}, @var{phis}, @var{f_RF}, [@var{phase_base_v}])
##
## Evaluate control voltage for @var{f_RF} in Hz and @var{phis} of synchronous phase.
## 
## If @var{phase_base_v} is given, "ci_phase_base" of @var{harm_ctrl} will be ignored.
## 
## @end deftypefn

function ctrlv = controlv_for_phase(self, rad, f_in_Hz, phase_base_v)
  if nargin < 4
    phase_base_v = forward_interp(self._properties.ci_phase_base...
                                , f_in_Hz);
  endif
  if isfield(self._properties, "pstable")
    pstable = self._properties.pstable;
    pscurve = pstable.curve_for_Hz(f_in_Hz);
    bias_rad = rad_for_v(pscurve, phase_base_v);
    ctrlv.phase = v_for_rad(pscurve, bias_rad + rad);
  else
    pscurve = self._properties.pscurve;
    bias_rad = rad_for_v(pscurve, phase_base_v);
    dv = v_for_rad(pscurve, bias_rad + rad) - v_for_rad(pscurve, bias_rad);
    ctrlv.phase = phase_base_v + dv;
  endif
  ctrlv.amp = forward_interp(self._properties.ci_amp, f_in_Hz);
  if nargout < 1
    printf("Control Voltage : phase %5.3f [V], amp %5.3f [V]\n" ...
          , ctrlv.phase, ctrlv.amp);
  endif
endfunction


