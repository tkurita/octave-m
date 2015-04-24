## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} shift_xlim(@var{dx})
## Shift the limits of the x-axis for the current plot.
## 
## Equivalent to xlim(xlim() + @var{dx})
##
## @end deftypefn

## $Date::                           $
## $Rev$
## $Author$

##== History
## 2015-04-24
## * first implementation

function retval = shift_xlim(dx)
  if ! nargin
    print_usage();
  endif
  retval = xlim(xlim() + dx);
endfunction

%!test
%! func_name(x)
