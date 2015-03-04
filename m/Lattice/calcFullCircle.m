## usage: fullCircle = calcFullCircle(cells, [HorV])
##
## matrix の配列 cells のすべての matrix をかけた物を返す。
##
##=Paramaters
## * HorV -- 横方向の matrix か縦方向かを指定
## "h" : 水平
## "v" : 縦
function fullCircle = calcFullCircle(cells,varargin)
  if (length(varargin) == 0)
    HorVList = {"h","v"};
  else
    HorVList = varargin;
  endif
  
  for i = 1:length(HorVList)
    HorV = HorVList{i};
    fullCircle.(HorV) = eye(3);
    for n = 1:length(cells)
      theElement = cells{n};
      fullCircle.(HorV) = theElement.mat.(HorV)*fullCircle.(HorV);
    endfor
  endfor
  
  if (length(HorVList) == 1)
    fullCircle = fullCircle.(HorVList{1});
  endif
endfunction