function digList = volToBits(volList)
  fgOutMax = 10 #[V] 関数発生器最大出力
  fgDigMax = 32768 # 関数発生器設定値の最大値

  digLine = volLine.*(analogOutMax/accVolMax * fgDigMax/fgOutMax);
endfunction