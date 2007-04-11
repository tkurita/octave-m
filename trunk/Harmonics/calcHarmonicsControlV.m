##useOwnTerm
function [phaseCtrlV, ampCtrlV] =\
  calcHarmonicsControlV(bmPattern, vPattern, captureFreq, timmings)
  
  ##= タイミングデータをインデックスに変換
  tStep = timmings.tStep;
  startCapIndex = timmings.startCaptureTime/tStep+1; # 加速電圧が発生しはじめる最初の時系列データのindex
  stopRFIndex = timmings.stopSecondRFTime/tStep+1;
  stopAmpIndex = timmings.stopAmpTime/tStep+1;
  #stopPhaseIndex = stopPhaseTime/tStep+1;
  
  ##= 定数
  C = 33.201; #[m] 周長
  lv = physicalConstant("light velocity");
  proton_eV = physicalConstant("proton [eV]");
  
  ##= 偏向電磁石パターン dBL/dt の構築
  [bLine, msecList] = BValuesForTimes(bmPattern, tStep, 0, timmings.endDataTime);
  #plot(msecList,bLine)
  secList = msecList/1000;
  dBLdtList = gradient(bLine, secList);
  #plot(secList,dBLdtList,";dBLdt;");
  
  ##= 加速電圧パターンの構築
  for n = 2:length(vPattern)
    vPattern(1,n) += vPattern(1, n-1);
  end
  vList=interp1(vPattern(1,:), vPattern(2,:), msecList, "linear"); #加速RF電圧
  #plot(msecList,vList);
  
  ##= 加速RF周波数の計算--偏向電磁石の磁場変化量から
  preVelocity = C*captureFreq;
  velocityList = [];
  dvdtList = [];
  for dBLdt = dBLdtList
    v = preVelocity;
    #theBeta = betaFromV(v);
    the_beta = v/lv;
    thedBrhodt = dBLdt/(pi/4);
    the_gamma =  (1 - the_beta^2)^(-1/2);
    dvdt = (lv^2 * thedBrhodt)/(proton_eV * (the_gamma + the_beta^2 * (1- the_beta^2 )^(-3/2) ));
    dvdtList = [dvdtList; dvdt];
    preVelocity = preVelocity + dvdt*(tStep/1000);
    velocityList = [velocityList;preVelocity];
  endfor
  
  #plot(secList,dvdtList,";dvdt;",secList,velocityList,";velocity;")
  rfHzList = velocityList./C;
  #plot(msecList,rfHzList,";RF [Hz];")
  
  ##= 加速位相の計算
  sinphi = (C.*dBLdtList'./(pi/4))./vList';
  sinphi(1:startCapIndex) = zeros(startCapIndex,1); # 電圧が発生されるまでを強制的に 0 にする。
  phiList=asin(sinphi);
  
  #plot(tList,phiList*306/(2*pi),"")
  #plot(degreeToControlV(phiList*306/(2*pi)))
  
  ############################################
  ##=２倍高調波制御装置の特性を計算するライブラリ
  #polyfit_A2_PM2
  
  ##= 2倍高調波位相の計算
  #PolyFit_PhaseShifter
  load(file_in_loadpath("A2_PM2.dat"))
  biasControlV = HzToPhaseControlV(rfHzList, A2_PM2);
  
  phase_shifter = load(file_in_loadpath("PhaseShifter.dat")); #特性データ
  bias_rad = controlVToRad(biasControlV, phase_shifter);
  phaseCtrlV = radToControlV(bias_rad + phiList, phase_shifter);
  
  ##== stopPhaseTime以降を一定にする。
  phaseCtrlV(stopRFIndex:length(phaseCtrlV)) = phaseCtrlV(stopRFIndex);
  
#  plot(msecList,biasControlV,";biasControlV;", msecList,phaseCtrlV,";phaseCtrlV;")
  
  
  ##= HP FG 用データ保存
  #  plot(phaseCtrlV)
  ## 2 倍高調波位相設定用に使われている function generator は設定通りの値がでない。
  ## 設定 : 150 mV → 出力 : 176 mV
  ## 設定 : 1.07V → 出力 : 1.25 V
  ## 約 1.17 倍になる。
  ## 
  ## SUM & INV の入力に 50 Ωターミネートをつけて
  ## 入力 : 176 mV → 出力 : 164 mV 
  ## 入力 : 1.25V → 1.19 V
  #saveBuffer = phaseCtrlV*-1*(1.07/1.19);
  #
  #save PhaseCtrl.dat saveBuffer;
  
  ###########################################
  ##= 2倍高調波の振幅の制御電圧を計算
  ampCtrlV = HzToAmpControlV(rfHzList, A2_PM2);
  
  ##== 立ち上がりを0Vから直線で立ち上げる。
  startingLineY = [0, ampCtrlV(startCapIndex)];
  startingLineX = [0, msecList(startCapIndex)];
  
  startingData = interp1(startingLineX,startingLineY,msecList(1:startCapIndex));
  ampCtrlV(1:startCapIndex) = startingData;
  
  ##== 立ち下がり部分を設定
  endingLineY = [ampCtrlV(stopAmpIndex), 0];
  endingLineX = [msecList(stopAmpIndex), timmings.stopSecondRFTime];
  
  endingData = interp1(endingLineX,endingLineY,msecList(stopAmpIndex:stopRFIndex));
  ampCtrlV(stopAmpIndex:stopRFIndex) = endingData;
  ampCtrlV(stopRFIndex:length(ampCtrlV)) = 0;
  #
  #plot(msecList,ampCtrlV,"")
  #
  #
  ##saveAsFGFormat("ampCtrlV2Time.csv",controlVtoBits(2.*ampCtrlV),"harmocis amplitude control voltage")
  ##saveAsFGFormat("ampCtrlV3Time.csv",controlVtoBits((3/2).*2.*ampCtrlV),"harmocis amplitude control voltage")
  ##saveDataBuffer = 2.*ampCtrlV;
  ##save ampCtrlV2Time.dat saveDataBuffer;
  #save AmpCtrlV.dat ampCtrlV
endfunction