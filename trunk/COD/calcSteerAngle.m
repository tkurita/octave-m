## Usage : kickAngle = calcSteerAngle(targetElement, iorB, brho)
##
## = Parameters
## * targetElement : a element structure to calculate kick angle
## * iorB : current of magnet or magnetic filed. depend on targetElement
## * brho

function kickAngle = calcSteerAngle(targetElement, iorB, brho)
  kickAngle = convertKickValues(targetElement, iorB, brho, true);
endfunction