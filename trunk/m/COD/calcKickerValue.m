## -*- texinfo -*-
## @deftypefn {Function File} {@var{iorB} =} calcKickerValue(@var{element}, @var{kick_angle}, @var{brho})
##
## Convert kick angle at the @var{element} into the current [A] or magnetic field [T].
##
## Arguments
## @table @code
## @item @var{element}
## A kicker object to calculate current or magnetic field.
## 
## @item @var{kick_angle}
## kick angle at @var{element}. The unit is radian.
##
## @item @var{brho}
## The b*rho value of the particle. The unit is [T*m].
## @end table
##
## @end deftypefn

##== History
## 2008-04-24
## * wrote function help with texinfo.

function iorB = calcKickerValue(targetElement, kickAngle, brho)
  iorB = convertKickValues(targetElement, kickAngle, brho, false);
endfunction