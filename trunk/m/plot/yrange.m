## useage : yrange(ymin,ymax)
##          yrange("reverse")
## no arguments set yrange to autoscale

function yrange(varargin)
  ca = gca();
  if (nargin > 0)
    set(ca, "ylim", [varargin{1},varargin{2}]);
  else
    set(ca, "ylimmode", "auto");
  endif
endfunction
