## -*- texinfo -*-
## @deftypefn {Function File} {@var{h} =} vline(@var{x} , [@var{properties}])
## Draw vertical lines.
##
## @strong{Inputs}
## @table @var
## @item @var{x}
## x position of the vertical line. row wise vector.
## @item @var{properties}
## line type. optional.
## @end table
##
## @strong{Outputs}
## @table @var
## @item @var{h}
## graphics handles of vertical lines.
## @end table
##
## @end deftypefn

##== History
## 2013-06-13
## * remove persisitent _ylim in _vline
## 2012-07-23
## * use arrayfun instead of map.
## 2011-07-27
## * first argument can be axes object
## 2007-10-31
## * use line instead of __gnuplot_raw__
## * The code chekcing automatic_replot is removed for compatibility to 2.9.14

function result = vline(varargin)
  if (length(varargin) > 1 &&  ishandle(varargin{1}))
    ca = varargin{1};
    set(gcf, "currentaxes", ca);
    varargin(1) = [];
  else
    ca = gca();
  endif
  
  x = varargin{1};
  varargin(1) = [];

  if (length(varargin) > 1)
    _vline("properties", varargin(2:end));
  end

  result = arrayfun(@_vline, x);
endfunction

function result = _vline(varargin)
  persistent _prop;
  if (ischar(varargin{1}))
    [_prop] = get_properties(varargin, {"properties"}, {_prop});
    return;
  end
  
  x = varargin{1};
  if (length(_prop) > 0)
    result = line([x,x], ylim(), _prop{:});  
  else
    result = line([x,x], ylim());
  endif
endfunction

