## usage : reset_plot
##
## reset gnuplot status

## 2007-04-13
## * initial

function reset_plot()
  __gnuplot_raw__("reset\n")
endfunction
