## usage : xyyplot({[X,Y], format ...}, {[X, Y2], format ...})
##
## accept column wise 2 dimensional matrix as X-Y data

## History
## 2007.04.13
##    first implementation for 2.9.9

function xyyplot2(xyarg, xy2arg)
  __plot_globals__;
  __setup_plot__ ("__gnuplot_plot__");
  
  build_plot_command(xyarg)
  build_plot_command(xy2arg, "axes x1y2");
  setupy2();
  eval (__plot_command__{__current_figure__}{__multiplot_xi__,__multiplot_yi__});
endfunction

function build_plot_command(varargin);
  if (length(varargin) < 1)
    return
  endif
  
  __plot_globals__;
  
  j = __plot_data_offset__{__current_figure__}(__multiplot_xi__,__multiplot_yi__);
  caller = "plot";
  data_set = false;
  pltarg = varargin{1};
  if (length(varargin) == 2)
    additionalOpt = [varargin{2}," "];
  else
    additionalOpt = "";
  endif
  
  for n = 1:length(pltarg)
    next_arg = pltarg{n};
    if (ischar(next_arg))
      if (data_set)
        fmt = __pltopt__ (caller, next_arg);
        fmtstr = sprintf("%s%s", additionalOpt, fmt);
        
        usingstr = __make_using_clause__ (__plot_data__{__current_figure__}{__multiplot_xi__,__multiplot_yi__}{j});
        __plot_command__{__current_figure__}{__multiplot_xi__,__multiplot_yi__} \
        = sprintf ("%s%s __plot_data__{__current_figure__}{__multiplot_xi__,__multiplot_yi__}{%d} %s %s",
        __plot_command__{__current_figure__}{__multiplot_xi__,__multiplot_yi__},
        __plot_command_sep__, j, usingstr, fmtstr);
        __plot_command_sep__ = ",\\\n";
        data_set = false;
        j++;
      endif
    else
      __plot_data__{__current_figure__}{__multiplot_xi__, __multiplot_yi__}{j} = next_arg;
      data_set = true;
    endif
  endfor
  
  __plot_data_offset__{__current_figure__}(__multiplot_xi__,__multiplot_yi__) = j;
  
endfunction
