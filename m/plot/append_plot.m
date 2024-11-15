## -*- texinfo -*-
## @deftypefn {Function File} {} append_plot(@var{xy}, @var{props}, ...)
## @deftypefnx {Function File} {} append_plot("colororder", @var{colors})
## @deftypefnx {Function File} {} append_plot("index")
## @deftypefnx {Function File} {} append_plot("reset")
##
## Append data to plot
## "colororder" property indicate colors of data.
## "reset" indicate to clear internal data index.
##
## @end deftypefn

##== History
## 2009-06-02
## * If no arguments, print_usage().
##
## 2008-03-10
## * first implementaion

function result = append_plot(varargin)
  if (!nargin)
    print_usage();
    return;
  endif
  
  persistent _colororder = [];
  persistent _data_index = 1;
  arg_ind = 1;
  if (ischar(varargin{1}))
    while (arg_ind <= length(varargin))
      switch varargin{arg_ind++}
        case "colororder"
          _colororder = varargin{arg_ind++};
        case "reset"
          _data_index = 1;
        case "index"
          result = _data_index;
          return;
        otherwise
          varargin{arg_ind}
          break;
      endswitch
    endwhile
    return
  endif
  
  if (arg_ind > length(varargin))
    return;
  endif

  varargin = varargin(arg_ind:end);
  #n_lines = length(get(get(gca, "children")));
  if (!contain_str(varargin, "color") )
    auto_color = [];
    
    if (length(_colororder))
      #"colororder is given"
      c_ind = resolve_color_index(_data_index++, rows(_colororder));
      auto_color = _colororder(c_ind, :);
    else
      #"colororder is not gien"
      plot_ind = length(get(gca, "children"));
      plot_ind++;
      colororder = get(gca, "colororder");
      n_colororder = rows(colororder);
      c_ind = resolve_color_index(plot_ind, n_colororder);
      auto_color = colororder(c_ind, :);
    end
    
    varargin{end+1} = "color";
    varargin{end+1} = auto_color;
  end
  #varargin
  hold on;
  if (columns(varargin{1})==2)
    xyplot(varargin{:});
  else
    plot(varargin{:});
  end
  hold off;
end

function result = resolve_color_index(plot_index, n_colororder)
  #"start resolve_color_index"
  while (n_colororder < plot_index)
    plot_index = plot_index - n_colororder;
  end
  #"end resolve_color_index"
  result = plot_index;
end

