## -*- texinfo -*-
## @deftypefn {Function File} {} xtick("on")
## @deftypefnx {Function File} {} xtick("off")
## @deftypefnx {Function File} {} xtick(@var{ticks})
##
## @end deftypefn

##== History
## 2009-07-01
## * If no arguments, print current xtick and current xtickmode.
##
## 2008-08-19
## * first implementation

function xtick(arg)
  if !(nargin)
    printf("xtick : %f\n", get(gca, "xtick"));
    printf("xtickmode : %s\n", get(gca, "xtickmode"));
    return;
  endif
  
  if ischar(arg)
    switch arg
      case "on"
        set(gca, "xtickmode", "auto");
      case "off"
        set(gca, "xtick", []);
        set(gca, "xtickmode", "manual");
    endswitch
  else
    set(gca, "xtick", []);
    set(gca, "xtickmode", "manual");
  end
endfunction

%!test
%! func_name(x)
