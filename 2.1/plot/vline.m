## usage : vline(x [,lt])
##
## Show vertival line.
## If no arguments are passed, all arrows are removed.
##
## = arguments
## * x -- x position of the vertical line
## * lt -- line type. optional

function vline(varargin)
  
  if (length(varargin) == 0) 
    unsetarrow();
    return;
  endif
  
  x = varargin{1};
  if (nargin == 2)
    lttext = sprintf("lt %i", lt);
  else
    lttext = "";
  endif
  
  eval (sprintf ("__gnuplot_set__(\"arrow from first %g,graph 0 to first %g,graph 1 nohead %s;\")"\
    , x, x, lttext));

  if (automatic_replot)
    replot ();
  endif

endfunction