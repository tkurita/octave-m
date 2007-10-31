## Usage : result = sumY([x1, y1], [x2, y2] ....)
##      result = [x1, y1+y2+...];

function result = sumY(varargin)
  xdata = varargin{1}(:,1);
  ydata = varargin{1}(:,2);
  for n = 2: length(varargin)
    ydata = ydata + varargin{n}(:,2);
  endfor
  result = [xdata, ydata];
endfunction