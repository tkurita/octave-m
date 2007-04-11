## usage: c = contourLength(allElements)
##
## 周長を計算する

function c = contourLength(allElements)
  c = 0;
  for i=1:length(allElements)
    c += allElements{i}.len;
  endfor
endfunction