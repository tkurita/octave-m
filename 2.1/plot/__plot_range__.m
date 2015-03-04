## useage : yrange(ymin,ymax)
##          yrange("reverse")
## no arguments set yrange to autoscale

function __plot_range__(axis_name, varargin)
  switch (length(varargin))
    case (0)
      __gnuplot_set__(sprintf("%s [*:*]", axis_name));
    case (1)
      if (ischar(varargin{1}))
        __gnuplot_set__(sprintf("%s [] %s", axis_name, varargin{1}));
      else
        __set_range__(axis_name, varargin{1}(1), varargin{1}(2));
      endif
      
    otherwise
      __set_range__(axis_name, varargin{1}, varargin{2});
  endswitch
  
  if (automatic_replot)
    replot ();
  endif
  
endfunction

function __set_range__(axis_name, ymin, ymax)
  __gnuplot_set__(sprintf("%s [%g:%g]", axis_name, ymin, ymax));
  #eval (sprintf ("__gnuplot_set__ yrange [%g:%g];",ymin, ymax));
endfunction
