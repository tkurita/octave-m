## -*- texinfo -*-
## @deftypefn {Function File} {@var{v} =} rad_for_v(@var{pscurve}, @var{v})
## Obtain phase corresponding to a control voltage of @var{v}.
## @end deftypefn


function retval = rad_for_v(x, v)
  if ! nargin
    print_usage();
  endif
  retval = interp1(x.v, x.rad, v);
endfunction
