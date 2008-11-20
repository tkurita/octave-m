## -*- texinfo -*-
## @deftypefn {Function File} {} xtick("on")
## @deftypefnx {Function File} {} xtick("off")
## @deftypefnx {Function File} {} xtick(@var{ticks})
##
## @end deftypefn

##== History
## 2008-08-19
## * first implementation

function retval = xtick(arg)
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
