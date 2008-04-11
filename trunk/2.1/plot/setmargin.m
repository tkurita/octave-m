## useage : setmargin(s, val)
##
## wrapper function to set (b|l|r|t)margin of gnuplot
##
## = Parameters
## * s -- a character to specify side, b|l|r|t
##
## = example
## setmargin("r", 10)

function setmargin(s, val)
  eval (sprintf ("__gnuplot_set__ %smargin %d;", s, val));
  
  if (automatic_replot)
    replot ();
  endif
  
endfunction
