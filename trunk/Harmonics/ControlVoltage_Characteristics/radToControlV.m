## Usage : ctrlVList = radToControlV(rad_list, phase_shifter)
##          ˆÚ‘Š—Ê [rad] ‚ğ‚Q”{‚’²”gM†ˆ—‘•’uiˆÚ‘ŠŠíj‚Ì§Œä“dˆ³ [V] ‚ğŒvZ
##
## = Parameters
## * radList -- [rad]
## * phaseShifter -- ˆÚ‘ŠŠí‚Ìü”g”“Á«

function ctrlVList = radToControlV(radList, phaseShifter)
  ## ˆÚ‘Š—Ê [rad] ‚©‚ç§Œä“dˆ³ [V] ‚ğŒvZ
  #global PhaseShifter;
  shiftRad = phaseShifter(:,3);
  controlV = phaseShifter(:,4);

  p = polyfit(shiftRad,controlV,5);
  ctrlVList = polyval(p,radList);
endfunction