## useage : yrange(ymin,ymax)
##          yrange("reverse")
## no arguments set yrange to autoscale

function yrange(varargin)
  __plot_range__("yrange", varargin{:});
endfunction
