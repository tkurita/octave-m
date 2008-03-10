## usage : hline(x)
##  縦線を表示する。
## arguments

function hline(x)

  eval (sprintf ("__gnuplot_set__ arrow from graph 0, first %g to graph 1,first %g nohead;",x,x));

  if (automatic_replot)
    replot ();
  endif

endfunction