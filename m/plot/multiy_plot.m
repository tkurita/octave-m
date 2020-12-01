## multiy_plot("nplot", nplot, ["spacing", yspace, "ylabelfontsize", fsize])
## ax = multiy_plot(index, ["ylabel", labelname, "color", c])
##
## Create y axis and axes as a plot region for multi y axes plot.
## 
## Example
##   t = linspace(0,pi, 100);
##   clf;
##   multiy_plot("spacing", 0.07, "nplot", 2); # initialize
##   ax = multiy_plot(1, "ylabel", "sin");
##   plot(t, sin(t));
##   multiy_plot(2, "ylabel", "tan");
##   plot(t, tan(t));
##   xlabel(ax, "[rad]");
##   xlim(ax, [1,2]); # changing xlim reflected to both plots.
##
## see also : append_yaxes

function retval = multiy_plot(varargin)
  if ! nargin
    print_usage();
    return;
  endif
  
  persistent spacing = 0.07;
  persistent nplot = 3;
  persistent base_axes = NA;
  persistent ylabelfontsize = 10;

  if ischar(varargin{1})
    n = 1;
    while n <= length(varargin)
      switch varargin{n}
        case "spacing"
          if (length(varargin) == 1)
            retval = spacing;
            return;
          endif
          spacing = varargin{++n};
        case "nplot"
          if (length(varargin) == 1)
            retval = nplot;
            return;
          endif
          nplot = varargin{++n};
        case "ylabelfontsize"
          if (length(varargin) == 1)
            retval = ylabelfontsize;
            return;
          endif
          ylabelfontsize = varargin{++n};
        otherwise
          error(["Unknown option : ", varargin{n}]);
      endswitch
      n++;
    endwhile
    return
  endif
  
  pltindex = varargin{1};
  
  c = NA;
  ylabeltext = NA;  
  n = 2;
  while n <= length(varargin)
    switch varargin{n}
      case "ylabel"
        ylabeltext = varargin{++n};
      case "color"
        c = varargin{++n};
    endswitch
    n++;
  endwhile
  
  if (pltindex == 1)
    base_axes = axes();
    set(get(base_axes, "ylabel"), "fontsize", ylabelfontsize);
    if ischar(ylabeltext)
      ylabel(base_axes, ylabeltext);
    endif
    pos = get(base_axes, "position");
    pos1 = pos(1);
    pos(1) = spacing*nplot;
    pos(3) = pos(3) - pos(1) + pos1;
    set(base_axes, "position", pos);
    retval = base_axes;
  else
    if isna(base_axes)
      base_axes = gca();
    endif
    retval = axes("position", get(base_axes, "position")
      , "color", "none", "visible", "off"...
      , "xticklabel", {}, "yticklabel", {}, "ytick", [], "xtick", []);
    addlistener(base_axes, "xlim", {@_xlimchanged, retval});
  endif

  if ischar(c)
    _set_color(retval, c);
  elseif !isna(c)
    _set_color(retval, c);
  else
    set(retval, "colororderindex", pltindex);
    c = get(retval, "colororder")(pltindex, :);
  endif

  cf = get(base_axes, "parent");
  set (cf, "nextplot", "add");

  if (1 == pltindex)
    set(base_axes, "ycolor", c);
  else
    if length(varargin) > 1
      yax = append_yaxes(retval, spacing*(pltindex-1), varargin{2:end});
    else
      yax = append_yaxes(retval, spacing*(pltindex-1));
    endif
    set(get(yax, "ylabel"), "fontsize", ylabelfontsize);
    set(cf, "currentaxes", retval);
  endif
  hold on;
endfunction

function _set_color(ax, c)
  if ischar(c)
    rgb = name2rgb(c);
  else
    rgb = c;
  endif
  co = get(ax, "colororder");
  set(ax, "colororder", [rgb; co]);
endfunction

function _xlimchanged(h, d, ax)
    set(ax, "xlim", get(h, "xlim"));
endfunction

%!test
%! func_name(x)
