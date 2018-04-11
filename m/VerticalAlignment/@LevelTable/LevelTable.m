## -*- texinfo -*-
## @deftypefn {Function File} {@var{obj} =} LevelTable(@var{names}, @var{data})
## Construct
## @strong{Inputs}
## @table @var
## @item names
## a cell array of elements
## @item data
## a matrix of levels. 
## a row indicate levels of an element.
## @end table
##
## @end deftypefn

function obj = LevelTable(names, data)
  if ! nargin
    print_usage();
    return;
  end
  obj.names = names;
  obj.data = data;
  obj = class(obj, "LevelTable");
end

%!test
%! func_name(x)
