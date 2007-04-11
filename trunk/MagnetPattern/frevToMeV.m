## usage : result = protonFrevToMeV(frev)
##
## ������g�� ���� proton �̃G�l���M�[���v�Z����
##
##= Parameters
## * frev -- ������g�� (revolution frequency) [Hz]
##
##= Results
## �G�l���M�[ [MeV]

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