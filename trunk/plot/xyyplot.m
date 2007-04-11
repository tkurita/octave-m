## usage : xyyplot({[X,Y], format ...}, {[X, Y2], format ...})
##
## accept column wise 2 dimensional matrix as X-Y data

function xyyplot(xyarg, xy2arg)
  buildPlotCommand()
  buildPlotCommand(xyarg)
  [gp_cmd, data] = buildPlotCommand(xy2arg, "axes x1y2");
  setupy2();
  eval(gp_cmd);
endfunction

function [varargout] = buildPlotCommand(varargin);
  persistent k;
  persistent gp_cmd;
  persistent data;
  persistent sep;
  if (length(varargin) < 1)
    k = 0;
    data = {};
    gp_cmd = "__gnuplot_plot__";
    sep = "";
    return
  endif
  
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
        gp_cmd = sprintf ("%s%s data{%d} %s%s", gp_cmd, sep, k, additionalOpt, fmt);
        sep = ",\\\n";
        data_set = false;
      endif
    else
      data{++k} = next_arg;
      data_set = true;
    endif
  endfor
  
  switch (nargout)
    case (1)
      varargout{1} = gp_cmd;
    case (2)
      varargout{1} = gp_cmd;
      varargout{2} = data;
  endswitch
  
endfunction

  
  
