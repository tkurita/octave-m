## useage : xrange(xmin,xmax)
## no arguments set xrange to autoscale

function xrange(varargin)
  __plot_range__("xrange", varargin{:});
endfunction
