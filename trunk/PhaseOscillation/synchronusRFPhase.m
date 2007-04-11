## usage: [phi_s,sinPhi_s] = synchronusRFPhase(bLine,tLine,vList,C)
## synchronus particle の加速位相を計算
## transition 前後、RFの位相と時間軸の関係等を無視して、0 - pi/2 の範囲で計算する。
## bGrad : 磁場の変化率
## vList : 電圧パターン
## C : 周長 [m] WERC は 33.201mm

function [phi_s,sinPhi_s] = synchronusRFPhase(bLine,tLine,vList,C)
  bGrad=gradient(bLine,tLine/1000); #time difference of BM magnetic field
  sinPhi_s = (C*bGrad/(pi/4))./vList;
  nanList = isnan(sinPhi_s);
  for i = 1: length(sinPhi_s)
	if (nanList(i))
	  sinPhi_s(i) = 0;
	endif
  endfor
	
#   if ( isnan(sinPhi_s(1)) )
# 	sinPhi_s(1) = 0;
#   endif
  phi_s =asin(sinPhi_s);
endfunction
