## useage : unsetarrow(i)
##          unsetarrow()
##
## unset arrow i
## When no argnmeunts are given all arrows are cleard.

##== History
## 2007-10-31
## * The code chekcing automatic_replot is removed for compatibility to 2.9.14

function unsetarrow(i)
  if (nargin > 0)
    eval(sprintf("__gnuplot_raw__ \"unset arrow %i\\n\"",i));
  else
    __gnuplot_raw__ "unset arrow\n";
  endif
  
  replot ();
endfunction