## -*- texinfo -*-
## @deftypefn {Function File} {} setfont(@var{fontproperties})
##
## @example
## setfont("fontname", "Osaka", "fontsize", 18);
## @end example
## 
## @end deftypefn

##== History
## 2010-07-29
## * First implementation

function retval = setfont(varargin)
  ##=== ticks label
  set(gca, varargin{:}); # axis ticks label

  ##=== xlabel
  xl = get(gca, "xlabel");
  set(xl, varargin{:});

  #=== ylabel
  yl = get(gca, "ylabel");
  set(yl, varargin{:});
endfunction