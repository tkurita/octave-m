## -*- texinfo -*-
## @deftypefn {Function File} {@var{v} =} v_for_rad(@var{pscurve}, @var{rad})
## Obtain control valtage corresponding to a phase of @var{rad}.
## @end deftypefn

function v = v_for_rad(self, rad)
  if ! nargin
    print_usage();
  endif
  v = polyval(self._properties.rad_to_v, rad);
endfunction
