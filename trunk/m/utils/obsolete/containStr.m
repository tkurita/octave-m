## usage : result = containStr(cells, string)
##
##= Parameters
## * cells -- cell array
## * string
##
##= Result
## cells ‚ª string ‚ðŠÜ‚ñ‚Å‚¢‚½‚ç true

##== History
## 2008-03-08
## * obsolete. renamed into contain_str

function result = containStr(cells, string)
  warning("containStr is deprecated. Use contain_str");
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

  