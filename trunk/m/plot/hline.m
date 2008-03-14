## usage : hline(x)
##  縦線を表示する。
## arguments

##== History
## 2008-03-10
## * reimplement fo version 3.0

function hline(varargin)
  ca = gca();
  ##global __xlim;
  _hline("xlim", get(ca, "xlim"));
  
  if (length(varargin) > 1)
    _hline("properties", varargin(2:end));
  end
  result = map(@_hline, varargin{1});
endfunction


function result = _hline(varargin)
  persistent _xlim;
  persistent _prop;
  
  if (ischar(varargin{1}))
    [_xlim, _prop] = get_properties(varargin, {"xlim", "properties"}, {_xlim, _prop});
    return;
  end
  
  y = varargin{1};
  if (!isempty(_prop) > 0)
    result = line(xlim, [y,y], _prop{:});  
  else
    result = line( xlim, [y,y]);  
  endif
endfunction

#function result = _hline(x)
#  global __xlim;
#  global __prop;
#  
#  if (length(__prop) > 0)
#    result = line([x,x], xlim, __prop{:});  
#  else
#    result = line([x,x], xlim);  
#  endif
#endfunction