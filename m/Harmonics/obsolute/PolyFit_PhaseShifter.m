1; #script file

## 2倍高調波制御装置の移相器の較正曲線（制御電圧と移相量の関係）から
## お互いの値を変化する。

global PhaseShifter
load(file_in_loadpath("PhaseShifter.dat")) #特性データ


function ctrlVList = degreeToControlV(degreeList)
  ## 移相量[degree] から 制御電圧 [V] を計算
  global PhaseShifter;
  shiftDeg = PhaseShifter(:,2);
  controlV = PhaseShifter(:,4);

  p = polyfit(shiftDeg,controlV,5);
  #p1 = [7.9087e-15,5.1459e-12,2.1164e-9,-8.9392e-7,6.2662e-3,-1.129e-2];
  ctrlVList = polyval(p,degreeList);
  #plot(shiftDeg,controlV,"*",shiftDeg,polyval(p,shiftDeg),"",shiftDeg,polyval(p1,shiftDeg))

# shiftRad = PhaseShifter(:,3);
# p = polyfit(shiftRad,controlV,5);
# p1 = [7.9087e-15,5.1459e-12,2.1164e-9,-8.9392e-7,6.2662e-3,-1.129e-2];
# plot(shiftRad,controlV,"*",shiftRad,polyval(p,shiftRad),"",shiftRad,polyval(p1,shiftRad))
endfunction

function degreeList = controlVToDegree(ctrlVList)
  ## 制御電圧 [V] から移相量[degree] を計算
  global PhaseShifter;
  shiftDeg = PhaseShifter(:,2);
  controlV = PhaseShifter(:,4);

  p = polyfit(controlV, shiftDeg,5);
  degreeList = polyval(p,ctrlVList);
endfunction

function ctrlVList = radToControlV(radList)
  ## 移相量 [rad] から制御電圧 [V] を計算
  global PhaseShifter;
  shiftRad = PhaseShifter(:,3);
  controlV = PhaseShifter(:,4);

  p = polyfit(shiftRad,controlV,5);
  ctrlVList = polyval(p,radList);
endfunction

function radList = controlVToRad(ctrlVList)
  ## 制御電圧[V] から移相量 [rad] を計算
  global PhaseShifter;
  shiftRad = PhaseShifter(:,3);
  controlV = PhaseShifter(:,4);

  p = polyfit(controlV, shiftRad,5);
  radList = polyval(p,ctrlVList);
endfunction