## useage: result = isBendingMagnet(theElement)
## 
## obsolete. use is_BM
## 
## Bendig Magnet であるかどうかを判定する。
## theElement.name が "BM"+"数字" でのとき、result = 1

function result = isBendingMagnet(theElement)
  warning("isBendingMagnet is obsolete. Use is_BM");
  findAns = findstr(theElement.name,"BM",0);
  if (length(findAns) && findAns(1)==1)
    isNumList = isdigit(theElement.name);
    if ((length(isNumList) > 2) && (isNumList(3)==1))
      result = 1;
    else
      result = 0;
    endif
  else
    result = 0;
  endif
endfunction