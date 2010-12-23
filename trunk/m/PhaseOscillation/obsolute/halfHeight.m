## usage : y = halfHeight(x)
##
## Use rfbucket_half_height instead of halfHeight.
##
## bucket half height at phase angle x
## when x = phi_s, give maximum buket half height Y(Gamma)
## global _phi_s; #phase angle of shychronus particle
## global _phi_1; #phase angle which give separatrix

##== History
## 2010-12-23
## * y2 ~ 0 で y2 がマイナスになることがある。abs をとってからsqrt する。

function y = halfHeight(x)
  warning("Use rfbucket_half_height instead of halfHeight.");
  global _phi_s;
  global _phi_1;
  if (_phi_s < pi/2 )
	transitionFlag = 1;
  else
	transitionFlag = -1;
  endif
  y2 = transitionFlag.*(cos(x) - cos(_phi_1) + (x - _phi_1).*sin(_phi_s));
  y = sqrt(abs(y2)); # abs をとらないと、y2 ~ 0 でマイナスになることがある。
endfunction
