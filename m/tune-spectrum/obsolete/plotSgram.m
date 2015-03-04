##== History
## 2009-06-01
## renamed to plot_spectrum
## * support ver. 3

function plotSgram(sGramRec, xval, yval);
  warning("plotSgram is obsolete. Use plot_spectrum.");
  if (nargin < 3)
    yval = "msec";
  endif
  
  if (strcmp(yval, "frame"))
    [x, z] = getfields(sGramRec, xval, "dBm");
    y = 1:rows(z);    
  else
    if (!isfield(sGramRec, yval))
      error(sprintf("%s is unknown Y value", yval));
    endif
    [x, y, z] = getfields(sGramRec, xval, yval, "dBm");
  endif
  #cblabel("dBm")
  #__gnuplot_raw__("set palette rgbformulae 30,13,-31\n");
  #contourMap3d(x, y, z);
  imagesc(x, y, z);
  ylabel_text = sprintf("[%s]",yval);
  ylabel(ylabel_text);
  xlabel_text = sprintf("[%s]",xval);
  xlabel(xlabel_text);
  colorbar();
endfunction