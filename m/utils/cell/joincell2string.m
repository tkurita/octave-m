## Usage : result = joincell2string(cells, separator)

function result = joincell2string(cells, separator)
  result = num2str(cells{1});;
  for n = 2:length(cells)
    val = cells{n};
    if (!ischar(val))
      val = num2str(val)
    endif
    
    result = [result, separator, num2str(cells{n})];
  endfor
endfunction