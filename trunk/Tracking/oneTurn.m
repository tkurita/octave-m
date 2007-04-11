## usage : result = oneTurn(allElements, particles, horv)
##
## 一周分の軌道を計算する。
##

function result = oneTurn(allElements, particles, horv)
  nElements = length(allElements);
  result = [];
  for i = 1:nElements
    result = [result, allElements{i}.mat.(horv) * particles];
  endfor
endfunction

## test code
onTurnResult = oneTurn(allElements, [5e-3; 0; 0], "h");
  