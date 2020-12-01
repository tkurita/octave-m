
## ax_list = xyyplot({[X,Y], format ...}, {[X, Y2], format ...})
##
## accept column wise 2 dimensional matrix as X-Y data

##== History
## 2010-12-28
## * First implementation for Octave 3.2

function ax = xyyplot(xy1arg, xy2arg)
  clf;
  f = get(0, "currentfigure");
  if (isempty(f))
    f = figure();
  endif
  
  ca = get(f, "currentaxes");
  is_plotyy_axes = false;
  if (isempty(ca))
    ax = [];
  elseif (strcmp(get(ca, "tag"), "plotyy"));
    ax = get(ca, "__plotyy_axes__");
    is_plotyy_axes = true;
  else
    "aaa"
    ax = ca;
  endif
  
  if (length(ax) > 2)
    for n = 3:length(ax)
      delete(ax(n));
    endfor
    ax = ax(1:2);
  elseif (length(ax) == 1)
    ax(2) = axes();
  elseif (isempty(ax))
    ax(1) = axes();
    ax(2) = axes();
  endif
  ax
  axes(ax(1))
  newplot()
  xyplot(xy1arg{:});
  cf = gcf();
  set(cf, "nextplot", "add");
  
  axes(ax(2));
  newplot();
  xyplot(xy2arg{:});
  
  set(ax(2), "yaxislocation", "right");
  set(ax(2), "position", get(ax(1), "position"));
  set(ax(2), "color", "none");
  xmax = realmin;
  xmin = realmax;
  for n = 1:length(ax)
    lines = get(ax(n), "children");
    for m = 1:length(lines)
      if (strcmp("line", get(lines(m), "type")))
        xdata =get(lines(m), "xdata");
        xmax = max([xdata(:); xmax]);
        xmin = min([xdata(:); xmin]);
      endif
    endfor
  endfor
  xl = [xmin, xmax];
  set(ax(1), "xlim", xl);
  set(ax(2), "xlim", xl);
  set(ax(2), "xticklabelmode", "manual");
  
  ## Tag the plotyy axes, so we can use that information
  ## not to mirror the y axis tick marks
#  set(ax, "tag", "plotyy")
#
#  ## Store the axes handles for the sister axes.
#  if (is_plotyy_axes) 
#    set(ax(1), "__plotyy_axes__", ax);
#    set(ax(2), "__plotyy_axes__", ax);
#  else
#    addproperty ("__plotyy_axes__", ax(1), "data", ax);
#    addproperty ("__plotyy_axes__", ax(2), "data", ax);
#  endif
  set(get(ax(1), "__legend_handle__"), "location", "northwest");
  set(cf, "nextplot", "replace");
endfunction
