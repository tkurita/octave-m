## usage : result = subtractCOD(cod1,cod2)
## 
## COD の 差分を計算する。
## cod1 - cod2
##
##= Parameters
## cod.BPM_name = positon [mm]

function result = subtractCOD(cod1,cod2)
  
  for [val, key] = cod2
    cod1.(key) -= val;
  endfor
  
  result = cod1;
endfunction