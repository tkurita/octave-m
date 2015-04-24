## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} toggle_xscale()
## @deftypefnx {Function File} {@var{retval} =} toggle_xscale(@var{ax})
## Toggle xscale of the current axis between "log" and "linear".
## @end deftypefn

## $Date::                           $
## $Rev$
## $Author$

function toggle_xscale(ax)
  if nargin < 1
    ax = gca;
  endif
  
  if strcmp(get(ax, "xscale"), "log")
    set(ax, "xscale", "linear");
    disp("set xscale linear");
  else
    set(ax, "xscale", "log");
    disp("set xscale log");
  endif
endfunction

%!test
%! func_name(x)
