## -*- texinfo -*-
## @deftypefn {Function File} {@var{obj} =} LevelTableBPM(@var{name_list}, @var{level_list})
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

function obj = LevelTableBPM(name_list, level_list)
  if ! nargin
    print_usage();
    return;
  endif
  
  data = [];
  names = {};
  n = 1;
  while n < (length(name_list) +1)
    a_name = name_list{n};
    [S, E, TE, M] = regexp(a_name, "(BPM3|BPM6)");
    if S > 0
      z_U = level_list{n++};
      z_D = level_list{n};
      names(end+1, 1) = M{1};
      data(end+1, 1) = (z_U+z_D)/2;
    else
      [S, E, TE, M] = regexp(a_name, "(PR\\d)");
      if S > 0
        names(end+1, 1) = M{1};
        data(end+1, 1) = level_list{n};
      end
    end
    n++;
  end
  obj.names = {};
  obj.data = [];
  obj = class(obj, "LevelTableBPM", LevelTable(names, data));
endfunction

%!test
%! func_name(x)
