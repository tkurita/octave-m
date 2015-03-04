## useage : pointsize(multiplier)
##
## set defalt points size of plot.
## no arguments means multiplier = 1.

function pointsize(multiplier)
  if (nargin == 0)
    __gnuplot_set__ pointsize 1;
  else
    #eval(sprintf("__gnuplot_set__ pointsize %g", multiplier));
    __gnuplot_set__(sprintf("pointsize %g", multiplier));
  endif
  
  if (automatic_replot)
    replot ();
  endif
  
endfunction