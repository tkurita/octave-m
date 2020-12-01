## -*- texinfo -*-
## @deftypefn {Function File} {@var{h} =} vline(@var{x} , [@var{properties}])
## @deftypefnx {Function File} {@var{h} =} vline(@var{axh_list}, @var{x})
## @deftypefnx {Function File} {@var{h} =} vline(@var{figh}, @var{x})
##
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
## a cell array of graphics handles of vertical lines.
## @end table
##
## @end deftypefn

function result = vline(varargin)
  axlist = NA;
  if (length(varargin) > 1) && (! ischar(varargin{2}))
    if ishandle(varargin{1})
      "ff"
      switch get(varargin{1}, "type")
        case "figure"
          axlist = find_axes(varargin{1});
        case "axes";
          axlist = varargin{1};
      end
    elseif ismatrix(varargin{1})
      axlist = varargin{1};
    else
      error("First argument is invalid.");
    end
  endif

  if isna(axlist)
    axlist = gca();
  else
    varargin(1) = [];
  end
  x = varargin{1};
  varargin(1) = [];
  if (length(varargin) > 1)
    _vline("properties", varargin);
  end
  _vline("axes", axlist);
  result = arrayfun(@_vline, x, "UniformOutput", false);
endfunction

function result = _vline(varargin)
  #varargin
  persistent _prop;
  persistent _axes;
  if (ischar(varargin{1}))
    switch varargin{1}
      case "properties"
        _prop = varargin{2};
        return;
      case "axes"
        _axes = varargin{2};
        return;
      otherwise
        error([varargin{1}, " is unknown key."]);
    end
  endif
  x = varargin{1};
  result = [];
  for n = 1:length(_axes)
    an_axes = _axes(n);
    if (length(_prop) > 0)
      #result(end+1) = line(an_axes, [x x], ylim(), _prop.properties{:});
      result(end+1) = line(an_axes, [x x], ylim(), _prop{:});
    else
      result(end+1) = line(an_axes, [x x], ylim());
    end
  end
endfunction

