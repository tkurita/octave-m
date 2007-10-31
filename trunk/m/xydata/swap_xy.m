## xydata の x と y を入れ替える。

function result = swap_xy(xydata)
  result = [xydata(:,2), xydata(:,1)];
endfunction
