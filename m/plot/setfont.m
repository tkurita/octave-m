## -*- texinfo -*-
## @deftypefn {Function File} {} setfont(@var{fontproperties})
##
## @example
## setfont("fontname", "Osaka", "fontsize", 18);
## @end example
## 
## @end deftypefn

##== History
## 2014-11-13
## * support multiple axis in a figure.
## 2010-07-29
## * First implementation

function retval = setfont(varargin)
  ax = findobj(gcf, "type", "axes");
  ##=== ticks label
  #set(ax, varargin{:}); # axis ticks label

  ##=== xlabel, ylabel
  for labelname = {"xlabel", "ylabel", "title"}
    lh = get(ax, labelname{1});
    if iscell(lh)
      lh = cell2mat(lh);
    endif
    label_handles = findobj(lh, "visible", "on");
    if (length(label_handles) > 0)
      set(label_handles, varargin{:});
    endif
  endfor
  
  set(findobj(gcf, "-property", "fontname"), varargin{:});
endfunction