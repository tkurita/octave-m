## yax = append_yaxes(ax, offset, ["clolor", c, "ylavel", label])
##
##   Append yaxes for axes ax for a multi y axes plot.
##
## Input
## - ax : axes
## - offset : offset of new yaxes from axes ax.
##
## Output
## - yax : new y axes.
##
## see also : multi_yplot

function retval = append_yaxes(ax, offset, varargin)
  if ! nargin
    print_usage();
    return;
  endif

  opts = get_properties(varargin, ...
                      {"color", NA;
                      "ylabel", NA});
  ax_pos = get(ax, "position");
  pos = [ax_pos(1)-offset ax_pos(2) 0.001 ax_pos(4)];
  if !ischar(opts.color) && isna(opts.color)
    lineobj = findobj(ax, "type", "line");
    if length(lineobj) > 0
      opts.color = get(lineobj(1), "color");
    else
      corder = get(ax, "colororder");
      corderidx = get(ax, "colororderindex");
      opts.color = corder(corderidx,:);
    endif
  endif
  yax = axes("position", pos, "xcolor", opts.color, "ycolor", opts.color);
  set(yax, "ylim", get(ax, "ylim"));
  addlistener(ax, "ylim", {@_ylimchanged, yax});
  tickslabel_off(yax, "x");
  if ischar(opts.ylabel)
    ylabel(opts.ylabel);
  endif
  retval = yax;
endfunction

function _ylimchanged(h, d, yax)
    set(yax, "ylim", get(h, "ylim"));
endfunction

%!test
%! func_name(x)
