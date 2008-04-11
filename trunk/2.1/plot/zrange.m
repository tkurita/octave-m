## useage : zrange(zmin,zmax)
##
## no arguments set zrange to autoscale

function zrange(varargin)
  __plot_range__("zrange", varargin{:});
endfunction
