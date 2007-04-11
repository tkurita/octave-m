## Usage : ctrlVList = radToControlV(rad_list, phase_shifter)
##          �ڑ��� [rad] ���Q�{�����g�M���������u�i�ڑ���j�̐���d�� [V] ���v�Z
##
## = Parameters
## * radList -- [rad]
## * phaseShifter -- �ڑ���̎��g������

function ctrlVList = radToControlV(radList, phaseShifter)
  ## �ڑ��� [rad] ���琧��d�� [V] ���v�Z
  #global PhaseShifter;
  shiftRad = phaseShifter(:,3);
  controlV = phaseShifter(:,4);

  p = polyfit(shiftRad,controlV,5);
  ctrlVList = polyval(p,radList);
endfunction