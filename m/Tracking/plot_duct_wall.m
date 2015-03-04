##== History
## 2007-11-27
## * initial implementation

function plot_duct_wall(elements ,horv, varargin)
  [scale, style] = get_properties(varargin, {"scale", "style"},...
                {1e3, {"marker", "*", "linewidth",2}});
  switch (horv)
    case "h"
      xory = "x";
    case "v"
      xory = "y";
    otherwise
      error("second argument must be 'h' or 'v'");
  endswitch
  
  max_list = [];
  min_list = [];
  position_list = [];
  current_pos = 0;
  for n = 1:length(elements)
    if (isfield(elements{n}, "duct"))
      max_list(end+1) = elements{n}.duct.([xory, "max"]);
      min_list(end+1) = elements{n}.duct.([xory, "min"]);
      position_list(end+1) = current_pos;
      max_list(end+1) = elements{n}.duct.([xory, "max"]);
      min_list(end+1) = elements{n}.duct.([xory, "min"]);
      current_pos += elements{n}.len;
      position_list(end+1) = current_pos;
    else
      if (length(position_list) > 0)
        line(position_list, max_list*scale, style{:});
        line(position_list, min_list*scale, style{:});
        max_list = [];
        min_list = [];
        position_list = [];
      end
    end
    
  end
  line(position_list, max_list*scale, style{:});
  line(position_list, min_list*scale, style{:});
  
end
    