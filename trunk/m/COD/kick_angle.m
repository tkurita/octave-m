## Usage : kickAngle = kick_angle(targetElement, iorB, brho)
##
## = Parameters
## * targetElement : a element structure to calculate kick angle
## * iorB : current of magnet or magnetic filed. depend on targetElement
## * brho

##== History
## 2008-05-09
## * renamed from calcSteerAngle

function retval = kick_angle(targetElement, iorB, brho)
  retval = convert_kicker_value(targetElement, iorB, brho, true);
endfunction