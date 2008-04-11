## useage : usetmargin(s)
##
## wrapper function to set (b|l|r|t)margin of gnuplot
##
## == Parameters
## * s -- a character to specify side, b|l|r|t
##
## == example
## unsetmargin("r")

function unsetmargin(s)
  eval(sprintf("__gnuplot_raw__ \"unset %smargin\\n\"", s));
  
  if (automatic_replot)
    replot ();
  endif
  
endfunction
