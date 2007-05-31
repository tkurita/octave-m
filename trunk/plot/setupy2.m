## usage : setupy2() -- setup
##         setupy2(false) -- unsetup
##
## setup y2 axis
##  * hide mirror of y axis on y2 axis
##  * show tics of y2 axis

## Author: tkurita
##
##== History
## 2007.04.13 
##  * if parameter is given and it's false, unsetup y2 axis
##
## 2006.??.??
##  * initial

function setupy2(varargin)
  if (length(varargin) > 0) 
    if (! varargin{1})
      __gnuplot_set__ ytics mirror;
      __gnuplot_raw__("unset y2tics\n");
      return
    endif
  endif
  
  __gnuplot_set__ ytics nomirror;
  __gnuplot_set__ y2tics;
endfunction
