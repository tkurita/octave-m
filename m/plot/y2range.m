## useage : y2range(y2min,y2max)
## no arguments set y2range to autoscale

function y2range(y2min,y2max)
  if (nargin == 0)
	__gnuplot_set__ y2range [*:*];
  else
	eval (sprintf ("__gnuplot_set__ y2range [%g:%g];",y2min, y2max));
  endif

  if (automatic_replot)
    replot ();
  endif

endfunction