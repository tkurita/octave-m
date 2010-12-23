## useage : zeroaxis(axisname)
## axisname : x|y|
## no arguments set xrange to autoscale

##== History
## 2010-12-23
## *reimplemented for octave 3.2

function zeroaxis(axisname, varargin)
  if ! nargin 
    axisname = "xy";
  endif
  if (strfind(axisname, "x"))
    vline(0, varargin{:});
  endif
  if (strfind(axisname, "y"))
    hline(0, varargin{:});
  endif

endfunction