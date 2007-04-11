##関数発生器の出力電圧と設定ビット値の関係
function digList = controlVtoBits(controlVList)
  fgOutMax = 10; #[V] 関数発生器最大出力
  fgDigMax = 32768; # 関数発生器設定値の最大値

  digList = controlVList.*(fgDigMax/fgOutMax);
endfunction