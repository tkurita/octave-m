## useage : xrange(xmin,xmax)
## no arguments set xrange to autoscale

function xrange(varargin)
  ca = gca();
  if (nargin > 0)
    set(ca, "xlim", [varargin{1},varargin{2}]);
  else
    set(ca, "xlimmode", "auto");
  endif
endfunction
