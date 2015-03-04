## usage: c = contourLength(allElements)
##
## 周長を計算する

##==History
## 2007-10-12
## * obsolute. use circumference

function c = contourLength(allElements)
  c = 0;
  for i=1:length(allElements)
    c += allElements{i}.len;
  endfor
endfunction