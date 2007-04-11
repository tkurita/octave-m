## usage:[allElements,tune] = calcLatticeForCOD(qfk,qdk)
## 
## Q の値をを与えて lattice と tune の結果だけを返す。
##
##= Parameters
## * qfk -- [(T/m) *m]
## * qdk
##
##= Results
## *
function [allElements,tune] = calcLatticeForCOD(qfk,qdk)
  matrixcollection;

##共通のパラメータ
# qlength = 0.15; #[m]
# global brho;

## proton
#最初の設計値
#qfk = 1.79066; 
#qdk = -1.8088; 

#加速終了時に使用されている値
#qfk = 1.7288; #[1/(m*m)] 
#qdk = -1.758; # [1/(m*m)]

## 捕獲時に使用されている値
# bl = 0.3662; #[T・m] 偏向電磁石の磁場
#qfk = 0.1172/brho/qlength; #[1/(m*m)] 
#qdk = -0.1253/brho/qlength; # [1/(m*m)]

## carbon
##捕獲時
# titleText = "carbon at capture priod";
# bl = 0.3299; #[T*m]
# brho = 4 * bl/pi ; #[rad]
# qdk = 0.1131/brho/qlength; #[1/(m*m)]
# qfk = 0.1058/brho/qlength; #[1/(m*m)]

##加速終了時
# titleText = "carbon before end of acceleration";
# bl = 1.6641; #[T*m]
# brho = 4 * bl/pi ; #[rad]
# qdk = 0.5695/brho/qlength; #[1/(m*m)]
# qfk = 0.5324/brho/qlength; #[1/(m*m)]
  
#global allElements;
  allElements = buildWERCMatrix(qfk,qdk);
  fullCircleMat.h = calcFullCircle(allElements,"h");

  fullCircleMat.v = calcFullCircle(allElements,"v");
  [betaFunction,dispersion,totalPhase,allElements] = calcLattice(allElements,fullCircleMat);

  ## show tunes
  tune.v = totalPhase.v/(2*pi);
  tune_v_comment = sprintf("vertial ture:%g",tune.v) #result 0.810899
  tune.h = totalPhase.h/(2*pi);
  tune_h_comment = sprintf("horizontal ture:%g",tune.h) #result 1.76185
endfunction
