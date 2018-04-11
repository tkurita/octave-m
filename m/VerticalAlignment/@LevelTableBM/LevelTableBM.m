## -*- texinfo -*-
## @deftypefn {Function File} {@var{obj} =} LevelTableBM(@var{name_list}, @var{level_list})
## Construct LavelTable for BM
## @strong{Inputs}
## @table @var
## @item name_list
## cell array of element names
## @item level_list
## cell array of level values
## @end table
##
## @end deftypefn

function obj = LevelTableBM(name_list, level_list)
  if ! nargin
    print_usage();
    return;
  endif
  
  data = [];
  names = {};
  n = 1;

  while n < (length(name_list) +1)
    a_name = name_list{n};
    [S, E, TE, M] = regexp(a_name, "(BM\\d)");
    if S > 0
      z_U = level_list{n++};
      z_C = level_list{n++};
      z_D = level_list{n};
      names(end+1, 1) = M{1};
      data(end+1, :) = [z_U, z_C, z_D];
    end
    n++;
  end
  
#  obj.names = names;
#  obj.data = data;
#  obj
  # obj = class(obj, "LevelTableBM", LevelTable({}, []));
  obj.names = {};
  obj.data = [];
  obj = class(obj, "LevelTableBM", LevelTable(names, data));
endfunction

%!test
%! func_name(x)
