function plotSgram(sGramRec, xval, yval);
  
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
  prevalue = automatic_replot;
  automatic_replot = false;
  ylabel_text = sprintf("[%s]",yval);
  ylabel(ylabel_text);
  xlabel_text = sprintf("[%s]",xval);
  xlabel(xlabel_text);
  cblabel("dBm")
  __gnuplot_raw__("set palette rgbformulae 30,13,-31\n");
  contourMap3d(x, y, z);
  automatic_replot = prevalue;
endfunction