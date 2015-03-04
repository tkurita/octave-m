function stB = steererAtoB(ampere)
## usage : function stB = steererAtoB(ampere)
## 
## ステアラーの電流から較正曲線をつかって発生磁場を計算する。
## ampere : ステアラーに流す電流量 [A]
## stB : 発生磁場 [T]
  phisLength = 50; #[mm]
  effLength = 218.41; #[mm]
  lengthfactor = effLength/phisLength;
#  stB = - lengthfactor * 0.004 .* ampere + 0.0012;
#  stB = - lengthfactor * 0.004 .* ampere;
  stB = - lengthfactor * 0.00402363 .* ampere + 0.00081426;
endfunction