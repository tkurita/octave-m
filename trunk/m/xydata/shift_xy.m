##== History
## 2007-11-27
## * first implementation

function xy_out = shift_xy(xy_in, varargin)
  [x,y] = get_properties(varargin, {"x","y"},{0,0});
  xy_out = xy_in + repmat([x,y], rows(xy_in), columns(xy_in)/2);
end