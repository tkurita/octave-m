## -*- texinfo -*-
## @deftypefn {Function File} {@var{ci} =} cross_interp(@var{x}, @var{y})
## Prepare spline interporate data of @var{x} and @var{y}.
##
## @strong{methods}
## @table @code
## @item forward_interp(@var{ci}, @var{xi})
## Obtain a value at @var{xi} with spline interpolation.
## @item reverse_interp(@var{ci}, @var{yi}
## Obtain a value for @var{yi}.
## @end table
##
## @end deftypefn

function retval = cross_interp(x, y)
  if ! nargin
    print_usage();
  endif
  pp = spline(x, y);
  s = struct("opts", struct() ...
           , "pp", pp ...
           , "x", x ...
           , "y", y);
  
  retval = class(s, "cross_interp");
endfunction
