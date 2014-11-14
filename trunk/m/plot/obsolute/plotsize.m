## useage : plotsize(x,y)
##

function plotsize(x,y)
  switch (nargin)
    case (0)
      __gnuplot_raw__("show size\n");
    case (1)
      if (strcmp(x, "reset"))
        __gnuplot_set__ size; # reset setting
      else
        error("invalid input");
      endif
    otherwise 
      __gnuplot_set__(sprintf("size %g,%g", x,y));
  endswitch
  
  if (automatic_replot)
    replot ();
  endif
  
endfunction