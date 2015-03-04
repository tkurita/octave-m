## -*- texinfo -*-
## @deftypefn {Function File} {@var{ctrlv} =} HzToAmpControlV(@var{Hz}, @var{A2_PM2})
## Obtain control voltage from frequency characteristics of harmonics processing unit.
## 
## @strong{Inputs}
## @table @var
## @item Hz
## list of frequency in Hz.
## @item A2_PM2
## a table of frequency characteristics
## @end table
##
## @strong{Outputs}
## @table @var
## @item ctrlv
## control voltage
## @end table
##
## @end deftypefn

# ２倍高調波信号処理装置の電圧設定の周波数特性
##== History
## 2012-10-04
## * use polyfit instead of wpolyfit.

function ctrlVList = HzToAmpControlV(hzList, A2_PM2)
  #global A2_PM2;
  fHz = A2_PM2(:,2);
  A2 = A2_PM2(:,3);
  #[p, s, mu] = wpolyfit(fHz,A2,8);
  [p, s, mu] = polyfit(fHz,A2,8);
  ctrlVList = polyval(p,(hzList-mu(1))./mu(2));
  #y1 = polyval(p,(fHz-mu(1))./mu(2));
  #plot(fHz,A2,"",fHz,y,"")
endfunction