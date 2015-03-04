## usage : result = frevToMeV(frev, "particle")
##
## 周回周波数からエネルギーを計算する
##
##= Parameters
## * frev -- 周回周波数 (revolution frequency) [Hz]
## * particle -- "proton" or "carbon"
##
##= Results
## エネルギー [MeV]

##== History
## 2008-03-03
## * obsolete

function result = frevToMeV(frev, particle)
  warning("frevToMeV is deprecated. Use mev_with_frev");
  mass_e = mass_energy(particle);
  v = frev * 33.201; #[m/s]
  lv = physicalConstant("light velocity");
  b = v/lv;
  g = 1/sqrt(1-b^2);
  result = mass_e*(g - 1);
endfunction

#frev = 5106250; #[Hz]
#frevToMeV(frev) ## 199.3 MeV