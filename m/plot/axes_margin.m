## -- axes_margin(hax, "right", rightmargin)
##    axes_margin("right", rightmargin)
##
## Set margins to axes.
##
## * Inputs *
##   hax : array of axes axes handles. If ommited, gca is used.
## 
## "left", "top", "bottom" options are not implemented.

function axes_margin(varargin)
  if ! ischar(varargin{1})
    hax = varargin{1};
    varargin = varargin(2:end);
  else
    hax = gca();
  endif

  opts = get_properties(varargin, {"right", NA});
  for ax = hax(:)'
    pos = get(ax, "position");
    if ! isna(opts.right)
      pos(3) = 1 - opts.right;
      set(ax, "position", pos);
    endif
  endfor
endfunction
