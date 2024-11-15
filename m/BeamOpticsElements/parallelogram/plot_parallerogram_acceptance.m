## -*- texinfo -*-
## @deftypefn {Function File} {} plot_parallerogram_acceptance(@var{para}, @var{horv} [, @{plot_opts}])
##
## plot a parallerogram return from parallelogram_acceptance.
## 
## The ploting Unit is [mm] and [mrad] ie. input value became 1000 times.
##
## @seealso{parallelogram_acceptance}
##
## @end deftypefn

##== History
## 2008-03-28
## * accept plot options
##
## 2007-11-27
## * initial implementaion

function plot_parallerogram_acceptance(a_para, horv, varargin)
  switch (horv)
    case "h"
      xory = "x";
    case "v"
      xory = "y";
    otherwise
      error("invalid argument.");
  endswitch
  
  a_list = [a_para.([xory, "max"]), a_para.([xory, "dash_max"]).l;
            a_para.([xory, "max"]), a_para.([xory, "dash_max"]).h;
            a_para.([xory, "min"]), a_para.([xory, "dash_min"]).h;
            a_para.([xory, "min"]), a_para.([xory, "dash_min"]).l;
            a_para.([xory, "max"]), a_para.([xory, "dash_max"]).l];
  if (length(varargin) > 0)
    xyplot(a_list *1000, "-@", varargin{:});
  else
    xyplot(a_list *1000, "-@");
  endif
end