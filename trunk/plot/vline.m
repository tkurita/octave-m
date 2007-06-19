## usage : vline(x [,lt])
##
## show vertival line
##
## = arguments
## * x -- x position of the vertical line
## * lt -- line type. optional

function vline(x, lt)
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