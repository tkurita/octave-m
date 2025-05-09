## splitCells -- 区切りとなる cell, ここで指定された cell が先頭になるように分割

function result = splitLattice(lattice, splitCells, withInclude)
  pre = 1;
  result = {};
  for i = 1:length(lattice)
    cell = lattice{i};
    if (containStr(splitCells, cell.name))
      if (withInclude)
        nextPre = i;
      else
        nextPre = i + 1;
      endif
      result = {result{:}, lattice(pre:i-1)};
      pre = nextPre;
    endif
  endfor
  
  if (pre < length(lattice))
    result = {result{:}, lattice(pre:end)};
  endif
  
endfunction
