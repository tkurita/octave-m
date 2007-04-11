##useOwnTerm
function [phaseCtrlV, ampCtrlV] =\
  calcHarmonicsControlV(bmPattern, vPattern, captureFreq, timmings)
  
  ##= �^�C�~���O�f�[�^���C���f�b�N�X�ɕϊ�
  tStep = timmings.tStep;
  startCapIndex = timmings.startCaptureTime/tStep+1; # �����d�����������͂��߂�ŏ��̎��n��f�[�^��index
  stopRFIndex = timmings.stopSecondRFTime/tStep+1;
  stopAmpIndex = timmings.stopAmpTime/tStep+1;
  #stopPhaseIndex = stopPhaseTime/tStep+1;
  
  ##= �萔
  C = 33.201; #[m] ����
  lv = physicalConstant("light velocity");
  proton_eV = physicalConstant("proton [eV]");
  
  ##= �Ό��d���΃p�^�[�� dBL/dt �̍\�z
  [bLine, msecList] = BValuesForTimes(bmPattern, tStep, 0, timmings.endDataTime);
  #plot(msecList,bLine)
  secList = msecList/1000;
  dBLdtList = gradient(bLine, secList);
  #plot(secList,dBLdtList,";dBLdt;");
  
  ##= �����d���p�^�[���̍\�z
  for n = 2:length(vPattern)
    vPattern(1,n) += vPattern(1, n-1);
  end
  vList=interp1(vPattern(1,:), vPattern(2,:), msecList, "linear"); #����RF�d��
  #plot(msecList,vList);
  
  ##= ����RF���g���̌v�Z--�Ό��d���΂̎���ω��ʂ���
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
  
  ##= �����ʑ��̌v�Z
  sinphi = (C.*dBLdtList'./(pi/4))./vList';
  sinphi(1:startCapIndex) = zeros(startCapIndex,1); # �d�������������܂ł������I�� 0 �ɂ���B
  phiList=asin(sinphi);
  
  #plot(tList,phiList*306/(2*pi),"")
  #plot(degreeToControlV(phiList*306/(2*pi)))
  
  ############################################
  ##=�Q�{�����g���䑕�u�̓������v�Z���郉�C�u����
  #polyfit_A2_PM2
  
  ##= 2�{�����g�ʑ��̌v�Z
  #PolyFit_PhaseShifter
  load(file_in_loadpath("A2_PM2.dat"))
  biasControlV = HzToPhaseControlV(rfHzList, A2_PM2);
  
  phase_shifter = load(file_in_loadpath("PhaseShifter.dat")); #�����f�[�^
  bias_rad = controlVToRad(biasControlV, phase_shifter);
  phaseCtrlV = radToControlV(bias_rad + phiList, phase_shifter);
  
  ##== stopPhaseTime�ȍ~�����ɂ���B
  phaseCtrlV(stopRFIndex:length(phaseCtrlV)) = phaseCtrlV(stopRFIndex);
  
#  plot(msecList,biasControlV,";biasControlV;", msecList,phaseCtrlV,";phaseCtrlV;")
  
  
  ##= HP FG �p�f�[�^�ۑ�
  #  plot(phaseCtrlV)
  ## 2 �{�����g�ʑ��ݒ�p�Ɏg���Ă��� function generator �͐ݒ�ʂ�̒l���łȂ��B
  ## �ݒ� : 150 mV �� �o�� : 176 mV
  ## �ݒ� : 1.07V �� �o�� : 1.25 V
  ## �� 1.17 �{�ɂȂ�B
  ## 
  ## SUM & INV �̓��͂� 50 ���^�[�~�l�[�g������
  ## ���� : 176 mV �� �o�� : 164 mV 
  ## ���� : 1.25V �� 1.19 V
  #saveBuffer = phaseCtrlV*-1*(1.07/1.19);
  #
  #save PhaseCtrl.dat saveBuffer;
  
  ###########################################
  ##= 2�{�����g�̐U���̐���d�����v�Z
  ampCtrlV = HzToAmpControlV(rfHzList, A2_PM2);
  
  ##== �����オ���0V���璼���ŗ����グ��B
  startingLineY = [0, ampCtrlV(startCapIndex)];
  startingLineX = [0, msecList(startCapIndex)];
  
  startingData = interp1(startingLineX,startingLineY,msecList(1:startCapIndex));
  ampCtrlV(1:startCapIndex) = startingData;
  
  ##== ���������蕔����ݒ�
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