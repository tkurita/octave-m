## -*- texinfo -*-
## @deftypefn {Function File} {@var{obj} =} LevelTableQM(@var{name_list}, @var{level_list})
## Construct LavelTable for QM
## @strong{Inputs}
## @table @var
## @item name_list
## cell array of element names
## @item level_list
## cell array of level values
## @end table
##
## @end deftypefn

function obj = LevelTableQM(name_list, level_list)
  if ! nargin
    print_usage();
    return;
  endif
  
  data = [];
  names = {};
  n = 1;
  while n < (length(name_list) +1)
    a_name = name_list{n};
    [S, E, TE, M] = regexp(a_name, "((QF|QD)\\d)");
    if S > 0
      z1 = level_list{n++};
      z2 = level_list{n};
      names(end+1, 1) = M{1};
      data(end+1, 1) = (z1+z2)/2;
    end
    n++;
  end
  obj.names = {};
  obj.data = [];
  obj = class(obj, "LevelTableQM", LevelTable(names, data));
endfunction

%!test
%! func_name(x)
