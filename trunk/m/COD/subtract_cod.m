## usage : result = subtract_cod(codAtBPM1 ,codAtBPM2)
## 
## COD の 差分を計算する。
## cod1 - cod2
##
##= Parameters
## cod.BPM_name = positon [mm]

##== History
## * 2007.10.02
## rename from subtractCOD

function result = subtract_cod(cod1,cod2)
  
  for [val, key] = cod2
    cod1.(key) -= val;
  endfor
  
  result = cod1;
endfunction