## usage : result = correration1(vector)
## 
## 自己相関関数を計算する
## 全体をずらしながら計算するので、ずらし幅が大きいときは計算点が少なくなる。
##

function result = correration1(vector)
  result = [];
  for n = 1:(length(vector) -1)
    vec1 = vector(1:end-n);
    vec2 = vector(1+n:end);
    result(end+1) = sum(vec1.*vec2)/length(vec1);
  endfor
endfunction