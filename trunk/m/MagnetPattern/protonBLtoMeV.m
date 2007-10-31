## usage : result = protonBLtoMeV(bl)
##
## proton の BM の BL積からエネルギーを計算する
##

function result = protonBLtoMeV(bl)
  global proton_MeV;
  global lv;
  global eC;
  brho = bl/(pi/4);
  result = sqrt( proton_MeV^2 + (brho*lv/1e6)^2 ) - proton_MeV;
endfunction

protonBLtoMeV(1.7067)