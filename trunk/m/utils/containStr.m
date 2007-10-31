## usage : result = containStr(cells, string)
##
##= Parameters
## * cells -- cell array
## * string
##
##= Result
## cells �� string ���܂�ł����� true

function result = containStr(cells, string)
  result = false;
  for i = 1:length(cells)
    s = cells{i};
    if (ischar(s))
      if (strcmp(s, string))
        result = true;
        break;
      endif
    endif
  endfor
endfunction

  