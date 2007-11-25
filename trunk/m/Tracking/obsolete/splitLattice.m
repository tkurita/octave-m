## splitCells -- ‹æØ‚è‚Æ‚È‚é cell, ‚±‚±‚Åw’è‚³‚ê‚½ cell ‚ªæ“ª‚É‚È‚é‚æ‚¤‚É•ªŠ„

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
