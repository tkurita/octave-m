## useage : unsetarrow(i)
##          unsetarrow()
##
## unset arrow i
## When no argnmeunts are given all arrows are cleard.

function unsetarrow(i)
  if (nargin > 0)
    eval(sprintf("__gnuplot_raw__ \"unset arrow %i\\n\"",i));
  else
    __gnuplot_raw__ "unset arrow\n";
  endif
  
  if (automatic_replot)
    replot ();
  endif
endfunction