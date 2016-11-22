## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} forward_interp(@var{ci}, @var{xi})
## Obtain interplated value at @var{xi}.
##
## @end deftypefn

function retval = forward_interp(ci, xi)
  if ! nargin
    print_usage();
  endif
  retval = ppval(ci.pp, xi);
endfunction

