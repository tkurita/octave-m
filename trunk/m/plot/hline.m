## usage : hline(x)
##  縦線を表示する。
## arguments

##== History
## 2013-06-13
## * use arrayfun instead of map
## * remover persisitent _xlim in _hline
## 2011-07-27
## * first argument can accept axes object.
## 2008-03-10
## * reimplement fo version 3.0

function hline(varargin)
  if (length(varargin) > 1 && ishandle(varargin{1}))
    ca = varargin{1};
    set(gcf, "currentaxes", ca);
    varargin(1) = [];
  else
    ca = gca();
  endif
  
  if (length(varargin) > 1)
    _hline("properties", varargin(2:end));
  end
  result = arrayfun(@_hline, varargin{1});
endfunction


function result = _hline(varargin)
  persistent _prop;
  
  if (ischar(varargin{1}))
    [_prop] = get_properties(varargin, {"properties"}, {_xlim, _prop});
    return;
  end
  y = varargin{1};
  if (!isempty(_prop) > 0)
    result = line(xlim(), [y,y], _prop{:});  
  else
    result = line(xlim(), [y,y]);  
  endif
endfunction
