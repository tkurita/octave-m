function [omega_s,Ee,eta] = synchroFrequency(alpha, nM, bLine, h, sinPhi_s, vList,C)
  ## シンクロトロン周波数を計算
  ## alpha : momentum compaction factor;
  ## nM: mass number 
  ## bLine : 磁場パターン
  ## h : harmonic number
  ## sihPhi_s : sin(phi_s) 
  ## phi_s : synchronus particle の RF phase angle
  ## vList : 電圧パターン
  ## omega_s : シンクロトロン周波数[rad/sec]
  ## Ee : 磁場に対応する全エネルギー
  ## eta : alpha - 1/gamma^2 
  ## C : シンクロトロンの周長 [m]
  #global C; # シンクロトロンの周長 [m]
  global lv; #光速
  global proton_eV; #陽子の質量 [eV]
  m0c2 = nM * proton_eV; #[eV]
  Ee2 = m0c2^2 + (bLine./(pi/4)).^2 .*lv^2; #[ev2]
  Ee = sqrt(Ee2); #[eV]
  eta = alpha - m0c2^2./Ee2; #
  cosphi = - sqrt(1 - sinPhi_s.^2);
  omegaC = 2 * pi*lv/C;
  omega_s = sqrt((eta .* h .* omegaC^2 .*vList .* cosphi)./(2 * pi .* Ee));
endfunction
