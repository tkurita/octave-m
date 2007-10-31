## Usage : iroB = calcKickerValue(targetElement, kickAngle, brho)
##
## = Parameters
## * targetElement : the element to calculate kick angle
## * iorB : current of magnet or magnetic filed. depend on targetElement
## * brho

function iorB = calcKickerValue(targetElement, kickAngle, brho)
  iorB = convertKickValues(targetElement, kickAngle, brho, false);
endfunction