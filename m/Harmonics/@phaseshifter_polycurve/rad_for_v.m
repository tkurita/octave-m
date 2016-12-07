## -*- texinfo -*-
## @deftypefn {Function File} {@var{v} =} rad_for_v(@var{pscurve}, @var{v})
## Obtain phase corresponding to a control voltage of @var{v}.
## @end deftypefn


function rad = rad_for_v(self, v)
  if ! nargin
    print_usage();
  endif
  rad = polyval(self._properties.v_to_rad, v);
endfunction
