function x = subsasgn(x, idx, val)
  switch idx(1).type
    case "."                            # x.y... = val
      if (length (idx) == 1)            # x.y = val
        x.(idx.subs) = val;
      endif
    otherwise
     error ("LevelTable: subsasgn: invalid subscripted assignment type");
  endswitch
endfunction
