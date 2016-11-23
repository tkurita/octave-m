## Usage : radList = controlVToRad(ctrlVList, phaseShifter)
##          §Œä“dˆ³ [V] ‚©‚çˆÚ‘Š—Ê [rad] ‚ğŒvZ
##
## = Parameters
## * ctrlVList -- [V]
## * phaseShifter -- ˆÚ‘ŠŠí‚ÌŠr³‹Èü

function radList = controlVToRad(ctrlVList, phaseShifter)
  #global PhaseShifter;
  shiftRad = phaseShifter(:,3);
  controlV = phaseShifter(:,4);

  p = polyfit(controlV, shiftRad, 8);
  radList = polyval(p, ctrlVList);
endfunction