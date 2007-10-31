## Usage : ctrlVList = HzToAmpControlV(hzList, A2_PM2)
##          ２倍高調波信号処理装置の電圧設定の周波数特性
##
## = Parameters
## * hzlist -- [Hz]
## * A2_PM2 -- 周波数特性データ

function ctrlVList = HzToAmpControlV(hzList, A2_PM2)
  #global A2_PM2;
  fHz = A2_PM2(:,2);
  A2 = A2_PM2(:,3);
  [p,s,mu]=wpolyfit(fHz,A2,8);
  ctrlVList = polyval(p,(hzList-mu(1))./mu(2));
  #y1 = polyval(p,(fHz-mu(1))./mu(2));
  #plot(fHz,A2,"",fHz,y,"")
endfunction