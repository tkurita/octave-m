## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} plot_spectrum(@var{specdata}, @var{xkind}, @var{ykind})
##
## Plot spectrum data @var{specdata} which is returned by load_spectrum_csv.
##
## @table @code
## @item @var{xkind}
## "MHz" or "Hz"
## @item @var{ykind}
## "frame" or "msec"
## @end table
## 
##
## @end deftypefn

##== History
## 2009-06-01
## * renamed from plotSgram
## * support ver. 3

function plot_spectrum(sGramRec, xval, yval);
  
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