##加速高周波電圧から制御電圧を求める
function controlVList = accVolToControlV(accVList)
  analogInputMax = 5; #[V] 加速高周波電圧設定信号の最大値
  accVolMax = 2000; #[V] 加速高周波電圧最大値

  controlVList = accVList.*(analogInputMax/accVolMax);
endfunction