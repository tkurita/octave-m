## Usage : result = sumY([x1, y1], [x2, y2] ....)
##      result = [x1, y1+y2+...];

##== History
## * deprecated. Use sum_y instead

function result = sumY(varargin)
  warning("sumY is deprecated. Use sum_y");
  xdata = varargin{1}(:,1);
  ydata = varargin{1}(:,2);
  for n = 2: length(varargin)
    ydata = ydata + varargin{n}(:,2);
  endfor
  result = [xdata, ydata];
endfunction