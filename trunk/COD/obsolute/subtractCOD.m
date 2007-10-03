## Usage : result = subtractCOD(cod1,cod2)
##  oboslute. use subtract_cod
##  
## COD の 差分を計算する。
## cod1 - cod2
##
##= Parameters
## cod.BPM_name = positon [mm]

##== History
## * 2007.10.02
## obsolute


function result = subtractCOD(cod1,cod2)
  warning("subtractCOD is obsolute, use subtract_cod");
  for [val, key] = cod2
    cod1.(key) -= val;
  endfor
  
  result = cod1;
endfunction