## usage : result = contain_str(cells, string)
##
##= Parameters
## * cells -- cell array
## * string
##
##= Result
## cells が string を含んでいたら index を返す。

##== History
## 2008-04-10
## index を返すようにした。
## 
## 2008-03-08
## renamed from containStr

function result = contain_str(cells, string)
  result = false;
  for n = 1:length(cells)
    s = cells{n};
    if (ischar(s))
      if (strcmp(s, string))
        result = n;
        break;
      endif
    endif
  endfor
endfunction

  