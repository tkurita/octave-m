## Usage : kickAngle = calcSteerAngle(targetElement, iorB, brho)
##
## = Parameters
## * targetElement : a element structure to calculate kick angle
## * iorB : current of magnet or magnetic filed. depend on targetElement
## * brho

##== History
## 2008-05-09
## * obsolute. 
## * use value for kick_angle

function kickAngle = calcSteerAngle(targetElement, iorB, brho)
  warning("calcSteerAngle is obsolete. Use kick_angle.");
  kickAngle = convertKickValues(targetElement, iorB, brho, true);
endfunction