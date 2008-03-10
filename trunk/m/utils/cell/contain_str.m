## usage : result = contain_str(cells, string)
##
##= Parameters
## * cells -- cell array
## * string
##
##= Result
## cells ‚ª string ‚ðŠÜ‚ñ‚Å‚¢‚½‚ç true

##== History
## 2008-03-08
## renamed from containStr

function result = contain_str(cells, string)
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

  