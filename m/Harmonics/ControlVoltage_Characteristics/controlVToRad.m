## Usage : radList = controlVToRad(ctrlVList, phaseShifter)
##          ����d�� [V] ����ڑ��� [rad] ���v�Z
##
## = Parameters
## * ctrlVList -- [V]
## * phaseShifter -- �ڑ���̊r���Ȑ�

function radList = controlVToRad(ctrlVList, phaseShifter)
  #global PhaseShifter;
  shiftRad = phaseShifter(:,3);
  controlV = phaseShifter(:,4);

  p = polyfit(controlV, shiftRad, 8);
  radList = polyval(p, ctrlVList);
endfunction