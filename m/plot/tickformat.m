## -- tickformat(ax, xory, template)
##    tickformat(xory, template)
##     set ticklabel format
##
##  * Inputs *
##    ax : axis handle. If omitted, gca is used.
##    xory : name of axis. ex) "x", "y"
##    template : printf style template string
##    
##  * Exmaple *
##    plot([1, 2, 3], [4, 5, 6])
##    ticklabel("y", "%e")
##
##  See also: 

function tickformat(varargin)
  switch nargin
    case {0, 1}
      print_usage();
      return;
    case 2
      ax = gca;
      axnm = varargin{1};
      template = varargin{2};
    otherwise
      ax = varargin{1};
      axnm = varargin{2};
      template = varargin{3};
  endswitch
  set(ax, [axnm, "ticklabel"], ...
      arrayfun(@(x) sprintf(template, x), get(ax, [axnm, "tick"]), ...
      "UniformOutput", false));
endfunction