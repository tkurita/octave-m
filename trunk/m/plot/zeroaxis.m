## useage : zeroaxis(axisname)
## axisname : x|y|x2|y2
## no arguments set xrange to autoscale

function zeroaxis(axisname)

  eval (sprintf ("__gnuplot_set__ %szeroaxis;",axisname));
#   if (nargin == 0)
# 	__gnuplot_set__ autoscale;
#   else
# 	eval (sprintf ("__gnuplot_set__ &szeroaxis [%g:%g];",axisname, xmax));
#   endif

  if (automatic_replot)
    replot ();
  endif

endfunction