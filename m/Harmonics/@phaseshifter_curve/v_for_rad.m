## -*- texinfo -*-
## @deftypefn {Function File} {@var{v} =} v_for_rad(@var{pscurve}, @var{rad})
## Obtain control valtage corresponding to a phase of @var{rad}.
## @end deftypefn

function retval = v_for_rad(x, rad)
  if ! nargin
    print_usage();
  endif
  retval = interp1(x.rad, x.v, rad);
endfunction
