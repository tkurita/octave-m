## Usage : ctrlVList = HzToPhaseControlV(hzList)
##          周波数 [Hz] で移相器が 0 を与える設定電圧 [V] を求める。
##
## = Parameters
## * hzList -- [Hz]
## * A2_PM2 -- ２倍高調波信号処理装置の周波数特性

function ctrlVList = HzToPhaseControlV(hzList, A2_PM2)
  #global A2_PM2;
  fHz = A2_PM2(:,2);
  PM2 = A2_PM2(:,4);
  [p,s,mu] = wpolyfit(fHz,PM2,6);
  ctrlVList = polyval(p,(hzList-mu(1))./mu(2));
  if (nargout < 1)
    y1 = polyval(p,(fHz-mu(1))./mu(2));
    p2 = [-13.28e-39;0.1445e-30;-0.4675e-24;-42.28e-21;3.04e-12;-6.168e-6;4.7445];
    y2 = polyval(p2,fHz);
    plot(fHz,PM2,"*",fHz,y1,"",fHz,y2,"")
  endif
endfunction