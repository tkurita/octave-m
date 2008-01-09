## usage : vline(x , [properties])
##
## Show vertival line.
##
## = arguments
## * x -- x position of the vertical line
## * properties -- line type. optional

##== History
## 2007-10-31
## * use line instead of __gnuplot_raw__
## * The code chekcing automatic_replot is removed for compatibility to 2.9.14

function result = vline(x, varargin)
  ca = gca();
  ylim = get(ca, "ylim");
  result = line([x,x], [ylim(1), ylim(2)], varargin{:});  
endfunction