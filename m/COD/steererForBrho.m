## ステアラの値を Bρ もしくは BL でスケーリングする。
function result = steererForBrho(kickValue, targetBrho, baseBrho)
  result = kickValue.*targetBrho./baseBrho;
endfunction