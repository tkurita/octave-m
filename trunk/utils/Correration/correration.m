## usage : corrRec = correration(corrRec)
##
## 自己相関関数を計算する
## 全体をずらしながら計算するので、ずらし幅が大きいときは計算点が少なくなる。
##
## = Parameter
##  .data
##  .interval
##
## = Result
##  .correration
##  .lag
##  .frequency

function corrRec = correration(corrRec, varargin)
  interval = corrRec.interval;
  
  if (length(varargin) > 0)
    switch (varargin{1})
      case "cross"
        corrRec.correration = xcorreration(corrRec.data1, corrRec.data2);
      otherwise
        corrRec.correration = correration2(corrRec.data);
    endswitch
    
  else
    corrRec.correration = correration2(corrRec.data);
  endif
  
  xstart = 0;
  xend = interval*(length(corrRec.correration) -1);
  corrRec.lag = xstart:interval:xend;
  corrRec.frequency = 1./corrRec.lag;
endfunction