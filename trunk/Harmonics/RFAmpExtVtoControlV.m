## usage: function ctlV = RFAmpExtVtoControlV(extV)
##
## 出力電圧に対応する制御電圧を計算する。
## 出力電圧(extV) 2000 V で制御電圧(ctlV) 5V 

function ctlV = RFAmpExtVtoControlV(extV)
  ctlV = 5.*extV./2000;
endfunction
