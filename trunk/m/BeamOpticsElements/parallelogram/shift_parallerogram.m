##== History
## 2007-11-27
## * initial implementaion

function para_obj = shift_parallerogram(para_obj, varargin)
  [x, xdash, y, ydash] =...
    get_properties(varargin, {"x","xdash", "y", "ydash"}, {0,0,0,0});
  offset = tars(x, xdash,y, ydash);
  for xory = {"x", "y"}
    for morn = {"max", "min"}
      para_obj.([xory{:}, morn{:}]) += offset.(xory);
      para_obj.([xory{:},"dash_", morn{:}]).l += offset.([xory{:},"dash"]);
      para_obj.([xory{:},"dash_", morn{:}]).h += offset.([xory{:},"dash"]);
    end
  end
end