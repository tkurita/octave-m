## usage : [phi1,info] = solvePhi1()
## separatrix を与える位相（saddle point でないもう一方）を計算する
## fhiEq(x) = 0によって与えられる。
## phi1 : saddle point でない separatrix を与える位相
## info : fhiEq(x) = 0 が解けたら 1
## saddle point : phi_2 = pi- phi_s

##== History
## 2010-12-21
## * renamed to solve_phi1

function [phi1,info] = solvePhi1(phi_s)
  ## debug
  #printf("start solvePhi1\n")
  #phi_s

  ## start code
  if (phi_s < pi/2) 
	initialValue = -(pi - phi_s); # after transition
  else
	initialValue = pi+phi_s; # before transition
  endif

  global _phi_s;
  _phi_s = phi_s;
  [phi1,info] = fsolve("fhiEq", initialValue);
  #printf("end solvePhi1\n")
endfunction

function y = fhiEq(x)
  ## x : phase angle which give separatrix
  global _phi_s; # phase angle of synchronus particle
  #phi_s
  y = cos(_phi_s) + cos(x) - (pi - _phi_s - x).*sin(_phi_s);
endfunction
