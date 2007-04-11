## usage : result = protonFrevToMeV(frev)
##
## 周回周波数 から proton のエネルギーを計算する
##
##= Parameters
## * frev -- 周回周波数 (revolution frequency) [Hz]
##
##= Results
## エネルギー [MeV]

function result = protonFrevToMeV(frev)
  global lv;
  global proton_MeV
  v = frev * 33.2; #[m/s]
  b = v/lv;
  g = 1/sqrt(1-b^2)
  result = proton_MeV*(g - 1)
endfunction

#frev = 5106250; #[Hz]
#frevToMeV(frev) ## 199.3 MeV