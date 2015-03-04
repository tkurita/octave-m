## usage : result = xcorreration(vec1, vec2)
##
## 相互相関関数を計算する
## 全体をずらしながら計算するので、ずらし幅が大きいときは計算点が少なくなる。
##
## = Parameter
##
## = Result
##

function result = xcorreration(vec1, vec2)
  result = [];
  for n = 0:(length(vec1) -1)
    vec1buff = vec1(1:end-n);
    vec2buff = vec2(1+n:end);
    [sumresult, count] = sumskipnan(vec1buff.*vec2buff);
    result(end+1) = sumresult/count;
  endfor
endfunction