##加速高周波電圧から制御電圧を求める
function outVList = scaleForSumAndInverse(inVList)
  outputInpedance = 473; #[Ω] 任意関数発生器の出力インピーダンス
  inputInpedance = 646; #[Ω] sum and inverse の入力インピーダンス
  #inputInpedance/(outputInpedance+inputInpedance)
  outVList = inVList./(inputInpedance/(outputInpedance+inputInpedance));
endfunction