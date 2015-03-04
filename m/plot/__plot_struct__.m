## usage : plotarg = __plot_struct__(plotRec)
##
## = Parameters
## plotRec a structure which have following fields
## * .plotarg -- cell array {[X, Y], format, ...}
## * .xlabel -- optional
## * .ylabel -- optional
##
## = Result
## cell array
## {X, Y, format, ...}

function plotarg = __plot_struct__(plotRec)
  pre_auto_replot = automatic_replot;
  automatic_replot = 0;
  unwind_protect
    fnames = fieldnames(plotRec);
    for n = 1:length(fnames)
      if (strcmp(fnames{n}, "plotarg"))
        plotarg = __plot_arg__(plotRec.plotarg{:});
      else
        funcHandle = str2func(fnames{n});
        #fnames{n};
        #plotRec.(fnames{n});
        funcHandle(plotRec.(fnames{n}));
      endif
      
    endfor
    
  unwind_protect_cleanup
    automatic_replot = pre_auto_replot;
  end_unwind_protect
endfunction