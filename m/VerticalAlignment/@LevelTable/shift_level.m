function lvtable = shift_level(lvtable, shiftv)
  % LevelTable = shift_level(LevelTable, shiftv)
  %     shift level data
  if ! nargin
    print_usage();
    return;
  endif
  lvtable.data = lvtable.data - shiftv;
endfunction

%!test
%! func_name(x)
