## usage : y = rfbucket_half_height(x)
## bucket half height at phase angle x
## when x = phi_s, give maximum buket half height Y(Gamma)
## global _phi_s; #phase angle of shychronus particle
## global _phi_1; #phase angle which give separatrix

##== History
## 2010-12-23
## * halfHeight から名称を変更
## * y2 ~ 0 で y2 がマイナスになることがある。abs をとってからsqrt する。

function y = rfbucket_half_height(x, phi_s, phi_1)
  global _phi_s;
  global _phi_1;
  if (nargin == 1)
    phi_s = _phi_s;
    phi_1 = _phi_1;
  endif
  
  if (phi_s < pi/2 )
	transitionFlag = 1;
  else
	transitionFlag = -1;
  endif
  y2 = transitionFlag.*(cos(x) - cos(phi_1) + (x - phi_1).*sin(phi_s));
  y = sqrt(abs(y2)); # abs をとらないと、y2 ~ 0 でマイナスになることがある。
endfunction
