## -- axes_margin(hax, "right", rightmargin)
##    axes_margin("right", rightmargin)
##    axes_margin("left", rightmargin, "top", topmargin, "bottom", bottommargin)
##
## Set margins to axes.
##
## * Inputs *
##   hax : array of axes axes handles. If ommited, gca is used.

function axes_margin(varargin)
  if ! ischar(varargin{1})
    hax = varargin{1};
    varargin = varargin(2:end);
  else
    hax = gca();
  endif

  opts = get_properties(varargin, {"right", NA; 
                                   "left", NA;
                                   "bottom", NA;
                                   "top", NA});
  for ax = hax(:)'
    pos = get(ax, "position");
    [lm, bm, w, h] = div_elem(pos);
    rm = 1 - (w + lm);
    tm = 1 - (h + bm);
    needset = false;
    if ! isna(opts.left)
      lm = opts.left;
      needset = true;
    endif
    if ! isna(opts.bottom)
      bm = opts.bottom;
      needset = true;
    endif    
    if ! isna(opts.right)
      rm = opts.right;
      needset = true;
    endif
    if ! isna(opts.top)
      tm = opts.top;
      needset = true;
    endif
    if needset
      pos = [lm, bm, 1 - (lm + rm), 1 - (bm + tm)];
      set(ax, "position", pos);
    endif
  endfor
endfunction
