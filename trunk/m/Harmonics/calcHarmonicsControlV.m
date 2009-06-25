
##shareTerm /Users/tkurita/WorkSpace/シンクロトロン/2倍高調波/特性データ/HP FG用データ/9200_10_180-280-400/HarmonicsControlV4.m

#function varargout =\
  calcHarmonicsControlV(bmPattern, vPattern, captureFreq, timmings)
  # timmings.tStep = 1; #[msec] HP FG 用
  # timmings.endDataTime  = 800; #[msec] 高調波パターンデータ終了
  # timmings.startCaptureTime = 25; #[msec] 捕獲開始タイミング
  # timmings.stopAmpTime = 290; #[msec] 高調波振幅停止
  # timmings.stopSecondRFTime = 300; #[msec] 高調波停止
  # timmings.stopPhaseTime = 310; #[msec] 高調波位相停止
  # Proton7To200MeVMagnet
  # Proton200MeVRFPattern
  # bmPattern = BMPattern;
  # vPattern = rfPattern_7200_10_50_300_400_50_20090624;
  # captureFreq = 1098216.05 #[Hz] 捕獲周波数
  ##== タイミングデータをインデックスに変換
  tStep = timmings.tStep;
  startCapIndex = timmings.startCaptureTime/tStep+1; # 加速電圧が発生しはじめる最初の時系列データのindex
  stopRFIndex = timmings.stopSecondRFTime/tStep+1;
  stopAmpIndex = timmings.stopAmpTime/tStep+1;
  #stopPhaseIndex = stopPhaseTime/tStep+1;
  
  ##== 定数
  C = 33.201; #[m] 周長
  #lv = physicalConstant("light velocity");
  lv = physical_constant("SPEED_OF_LIGHT_IN_VACUUM" );
  #proton_eV = physicalConstant("proton [eV]");
  proton_eV = physical_constant("PROTON_MASS_ENERGY_EQUIVALENT_IN_MEV");
  
  ##= 偏向電磁石パターン dBL/dt の構築
  [bLine, msecList] = bvalues_for_period(bmPattern, tStep, 0, timmings.endDataTime);
  #plot(msecList,bLine)
  secList = msecList/1000;
  dBLdtList = gradient(bLine)./gradient(secList);
  #plot(secList,dBLdtList,";dBLdt;");
  
  ##= 加速電圧パターンの構築
  for n = 2:length(vPattern)
    vPattern(1,n) += vPattern(1, n-1);
  end
  vList=interp1(vPattern(1,:), vPattern(2,:), msecList, "linear"); #加速RF電圧
  #plot(msecList,vList);
  
  ##== 加速RF周波数の計算--偏向電磁石の磁場変化量から-- うまくいっていない 2009-06-25
  #  preVelocity = C*captureFreq;
  #  velocityList = [];
  #  dvdtList = [];
  #  for dBLdt = dBLdtList
  #    v = preVelocity
  #    #theBeta = betaFromV(v);
  #    b = v/lv;
  #    dbrho_dt = dBLdt/(pi/4);
  #    the_gamma =  (1 - b^2)^(-1/2);
  #    dvdt = (lv^2 * dbrho_dt)/(proton_eV * (the_gamma + b^2 * (1- b^2 )^(-3/2) ));
  #    dvdtList = [dvdtList; dvdt];
  #    preVelocity = preVelocity + dvdt*(tStep/1000);
  #    velocityList = [velocityList;preVelocity];
  #  endfor
  
  #plot(secList,dvdtList,";dvdt;",secList,velocityList,";velocity;")
   ##== 加速RF周波数の計算--偏向電磁石の磁場から
  velocityList = velocity_with_brho(bLine/(pi/4), "proton", 1);
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
  if nargout == 2
    varargout = {phaseCtrlV, ampCtrlV};
  else
    argout = tars(phaseCtrlV, ampCtrlV, rfHzList, phiList);
    varargout = {argout};
  endif
endfunction