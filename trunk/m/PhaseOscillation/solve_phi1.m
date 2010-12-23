## usage : [phi1,info] = solvePhi1()
## separatrix を与える位相（saddle point でないもう一方）を計算する
## fhiEq(x) = 0によって与えられる。
## phi1 : saddle point でない separatrix を与える位相
## info : fhiEq(x) = 0 が解けたら 1
## saddle point : phi_2 = pi- phi_s

##== History
## 2010-12-23
## * phi_s = 0.26 の解き、正負がひっくり返った答えが返される。
##   初期値を僅かに(+0.01)ずらすと解決した。

function [phi1,info] = solve_phi1(phi_s)
  # phi_s = 0.26

  ## start code
  if (phi_s < pi/2) 
    # phi_init = -(pi - phi_s); # below transition
    phi_init = - (pi- phi_s)+0.01; # below transition
  else
    phi_init = pi+phi_s; # above transition
  endif

  global _phi_s;
  _phi_s = phi_s;
  # fhiEq(phi_init);
  [phi1,info] = fsolve(@fhiEq, phi_init);
  #printf("end solvePhi1\n")
endfunction

function y = fhiEq(x)
  ## x : phase angle which give separatrix
  global _phi_s; # phase angle of synchronus particle
  #phi_s
  y = cos(_phi_s) + cos(x) - (pi - _phi_s - x).*sin(_phi_s);
endfunction
