## -*- texinfo -*-
## @deftypefn {Function File} {@var{iorB} =} calcKickerValue(@var{element}, @var{kick_angle}, @var{brho})
##
## Convert kick angle at the @var{element} into the current [A] or magnetic field [T].
##
## Deprecated. Use value_for_kickangle.
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
## * Deprecated. Use ib_for_kickangle.
## * wrote function help with texinfo.

function iorB = calcKickerValue(targetElement, kickAngle, brho)
  warning("calcKickerValue is obsolete. Use ib_for_kickangle.");
  iorB = convertKickValues(targetElement, kickAngle, brho, false);
endfunction