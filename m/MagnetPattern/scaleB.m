## result = scaleB(refB, refEnergy, targetE, kind)
##
## refB（磁場, Bρ or BL or 電流値）とrefEneryg（エネルギー）から 
## targetE（エネルギー）に対応する磁場をスケーリングによって求める。
##
##= Parameters
## * refB -- 磁場の参照値, Bρ or BL or 電流値
## * refEnergy -- エネルギーの参照値 [MeV]
## * targetE -- 磁場の値を求めたいエネルギー
## * kind -- "proton" or "carbon"
##
##= Result
## targetE に対応した磁場
##

##== History
## 2011-01-26
## * avoid global variables

function result = scaleB(refB, refEnergy, targetE, particle)
  mass = mass_energy(particle);
  result = sqrt(targetE.*(2.*mass + targetE)./(refEnergy.*(2.*mass + refEnergy))) .* refB;
endfunction

%!test
% scaleB(1.7067, 200, 180, "proton")
#scaleB(1.7232, 660, 264, "carbon")
#scaleB(1.7232, 660, 264, "carbon")