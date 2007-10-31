## usage : y = halfHeight(x)
## bucket half height at phase angle x
## when x = phi_s, give maximum buket half height Y(Gamma)
## global _phi_s; #phase angle of shychronus particle
## global _phi_1; #phase angle which give separatrix

function y = halfHeight(x)
  global _phi_s;
  global _phi_1;
  if (_phi_s < pi/2 )
	transitionFlag = 1;
  else
	transitionFlag = -1;
  endif
  y = sqrt(transitionFlag.*(cos(x) - cos(_phi_1) + (x - _phi_1).*sin(_phi_s)) );
endfunction
