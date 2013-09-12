## Usage : ctrlVList = radToControlV(rad_list, phase_shifter)
##          移相量 [rad] を２倍高調波信号処理装置（移相器）の制御電圧 [V] を計算
##
## = Parameters
## * radList -- [rad]
## * phaseShifter -- 移相器の周波数特性

function ctrlVList = radToControlV(radList, phaseShifter)
  ## 移相量 [rad] から制御電圧 [V] を計算
  #global PhaseShifter;
  shiftRad = phaseShifter(:,3);
  controlV = phaseShifter(:,4);

  p = polyfit(shiftRad,controlV,5);
  ctrlVList = polyval(p,radList);
endfunction