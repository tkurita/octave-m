## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} controlv_for_phase(@var{harm_ctrl}, @var{phase}, @var{freq})
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
  else
    pscurve = self._properties.pscurve;
  endif
  phase_ctrlv = phase_base_v;
  bias_rad = rad_for_v(pscurve, phase_base_v);
  ctrlv.phase = v_for_rad(pscurve, bias_rad + rad);
  ctrlv.amp = forward_interp(self._properties.ci_amp, f_in_Hz);
endfunction


