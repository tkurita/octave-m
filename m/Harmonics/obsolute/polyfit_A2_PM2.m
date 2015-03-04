1; #script file
## 高調波制御装置の設定電圧（振幅と位相）の周波数特性
global A2_PM2
load(file_in_loadpath("A2_PM2.dat"))

function ctrlVList = HzToAmpControlV(hzList)
  global A2_PM2;
  fHz = A2_PM2(:,2);
  A2 = A2_PM2(:,3);
  [p,s,mu]=wpolyfit(fHz,A2,8);
  ctrlVList = polyval(p,(hzList-mu(1))./mu(2));
  #y1 = polyval(p,(fHz-mu(1))./mu(2));
  #plot(fHz,A2,"",fHz,y,"")
endfunction

function hzList = ampControlVToHz(ctrlVList)
  global A2_PM2;
  fHz = A2_PM2(:,2);
  A2 = A2_PM2(:,3);
  [p,s,mu]=wpolyfit(A2,fHz,8);
  hzList = polyval(p,(ctrlVList-mu(1))./mu(2));
endfunction

function ctrlVList = HzToPhaseControlV(hzList)
  global A2_PM2;
  fHz = A2_PM2(:,2);
  PM2 = A2_PM2(:,4);
  [p,s,mu]=wpolyfit(fHz,PM2,6);
  ctrlVList = polyval(p,(hzList-mu(1))./mu(2));
  if (nargout < 1)
    y1 = polyval(p,(fHz-mu(1))./mu(2));
    p2 = [-13.28e-39;0.1445e-30;-0.4675e-24;-42.28e-21;3.04e-12;-6.168e-6;4.7445];
    y2 = polyval(p2,fHz);
    plot(fHz,PM2,"*",fHz,y1,"",fHz,y2,"")
  endif
endfunction

function ctrlVList = HzToPhaseControlV2(hzList)
  ## 高調波設定ソフトに入力されている特性データ
  global A2_PM2;
  p2 = [-13.28e-39;0.1445e-30;-0.4675e-24;-42.28e-21;3.04e-12;-6.168e-6;4.7445];
  ctrlVList = polyval(p2,hzList);
endfunction