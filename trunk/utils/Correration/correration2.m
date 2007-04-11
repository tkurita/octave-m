## usage result = correration2(vector)
##
## 自己相関を計算する。
## vector の半分の点だけをずらしながら計算するので、計算点の数はすべて同じ

function result = correration2(vector)
  result = [];
  vec1 = vector(1:length(vector)/2);
  veclen = length(vec1);
  for n = 0:veclen
    vec2 = vector(1+n:veclen+n);
    result(end+1) = sum(vec1.*vec2)/veclen;
  endfor
endfunction