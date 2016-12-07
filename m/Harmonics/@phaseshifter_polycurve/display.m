## -*- texinfo -*-
## @deftypefn {Function File} {} display(@var{phaseshifter_curve})
##
## @end deftypefn

function display(x)
  if ! nargin
    print_usage();
    return;
  endif
  printf("%6s  %6s\n", "[rad]", "[V]");
  printf("%6.4f  %6.4f\n", x.rad, x.v);
endfunction

