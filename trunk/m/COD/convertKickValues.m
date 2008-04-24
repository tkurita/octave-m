## Usage : retval = convertKickValues(targetElement, inVal, brho, isOutAngle)
##
## = Parameters
## * targetElement : the element to calculate kick angle
## * inVal : current of magnet or magnetic filed. depend on targetElement
##          kick angle
## * brho : indicate momentum
## * isOutAngle : bool value
##          if true, inVal must be current or BL, retvalue is kick angle.
## = Result
## kick angle or current setting or BL value

##= History
## 2008-04-24
## * resolving the conversion factor from the function returned by itobl_definition.
## 
## 2006-11-26
## * SM の 変換の際に符号を反転させるようにした。
## * iorB > 0 の時、内側にキック kick angle < 0 とするため。

function retval = convertKickValues(targetElement, inVal, brho, isOutAngle)
  itobl_def = itobl_definition();
  itobl = itobl_def(targetElement);
  retval = calc_output(inVal, itobl, brho, isOutAngle);
endfunction

function retval = calc_output(inVal, blFactor, brho, isOutAngle)
  kickF = blFactor/brho;
  if (isOutAngle)
    retval = kickF*inVal; # retval is angle, inVal is current.
  else
    retval = inVal/kickF; #retval is current, inValu is angle.
  endif
endfunction