## usage : vline(x , [properties])
##
## Show vertival line.
##
## = arguments
## * x -- x position of the vertical line
## * properties -- line type. optional

##== History
## 2011-07-27
## * first argument can be axes object
## 2007-10-31
## * use line instead of __gnuplot_raw__
## * The code chekcing automatic_replot is removed for compatibility to 2.9.14

function result = vline(varargin)
  if (ishandle(varargin{1}))
    ca = varargin{1};
    set(gcf, "currentaxes", ca);
    varargin(1) = [];
  else
    ca = gca();
  endif
  
  x = varargin{1};
  varargin(1) = [];

  global __ylim;
  __ylim = get(ca, "ylim");
  global __prop;
  __prop = varargin;
  result = map(@_vline, x);
endfunction

function result = _vline(x)
  global __ylim;
  global __prop;
  if (length(__prop) > 0)
    result = line([x,x], ylim, __prop{:});  
  else
    result = line([x,x], ylim);  
  endif
endfunction