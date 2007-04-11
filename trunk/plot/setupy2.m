## usage : setupy2()
##
## y2 軸の設定
## y2 軸上で.....y軸の mirror tics を消す
##               y2軸に自分の tics を表示
## 
## Author: tkurita

function setupy2()
  __gnuplot_set__ ytics nomirror;
  __gnuplot_set__ y2tics;
endfunction
