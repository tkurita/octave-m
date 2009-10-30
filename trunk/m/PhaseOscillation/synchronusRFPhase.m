## usage: [phi_s,sinPhi_s] = synchronusRFPhase(bLine,tLine,vList,C)
## synchronus particle の加速位相を計算
## transition 前後、RFの位相と時間軸の関係等を無視して、0 - pi/2 の範囲で計算する。
## bGrad : 磁場の変化率
## vList : 電圧パターン
## C : 周長 [m] WERC は 33.201mm

##== History
## 2009-10-30
## * It looks that gradient(tLine/1000) is needed. gradient was changed ?

function [phi_s,sinPhi_s] = synchronusRFPhase(bLine,tLine,vList,C)
  bGrad=gradient(bLine, gradient(tLine/1000)); #time difference of BM magnetic field
  sinPhi_s = (C*bGrad/(pi/4))./vList;
  nanList = isnan(sinPhi_s);
  sinPhi_s(isnan(sinPhi_s)) = 0;
  phi_s =asin(sinPhi_s);
endfunction
