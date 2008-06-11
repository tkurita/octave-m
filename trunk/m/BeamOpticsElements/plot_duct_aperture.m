## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} func_name(@var{arg})
##
## @end deftypefn

##== History
## 2008-06-11
## * first implementation

function retval = plot_duct_aperture(elem, horv, outfactor)
  # elem = element_with_name(track_rec, "BMD4OUT");
  if (nargin < 3)
    outfactor = 1;
  endif

  switch (horv)
    case "h"
      xory = "x";
    case "v"
      xory = "y";
  endswitch
  vline(elem.duct.([xory, "max"])*outfactor);
  vline(elem.duct.([xory, "min"])*outfactor)
endfunction