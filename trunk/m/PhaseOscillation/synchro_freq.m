## シンクロトロン周波数を計算
## alpha : momentum compaction factor;
## particle: mass number or "proton", "helium", "carbon"
## bLine : 磁場パターン
## h : harmonic number
## sihPhi_s : sin(phi_s) 
## phi_s : synchronus particle の RF phase angle
## vList : 電圧パターン
## C : シンクロトロンの周長 [m]
##
## omega_s : シンクロトロン周波数[rad/sec]
## Ee : 磁場に対応する全エネルギー
## eta : alpha - 1/gamma^2 


##== History
## 2010-12-21
## * renamed from synchroFrequency

function [omega_s,Ee,eta] = synchro_freq(alpha, particle, bLine, h, sinPhi_s, vList,C)
  lv = physical_constant("SPEED_OF_LIGHT_IN_VACUUM"); #光速
  m0c2 = mass_energy(particle)*1e6; #[eV]
  Ee2 = m0c2^2 + (bLine./(pi/4)).^2 .*lv^2; #[ev2]
  Ee = sqrt(Ee2); #[eV]
  eta = alpha - m0c2^2./Ee2; #
  cosphi = - sqrt(1 - sinPhi_s.^2);
  omegaC = 2 * pi*lv/C;
  omega_s = sqrt((eta .* h .* omegaC^2 .*vList .* cosphi)./(2 * pi .* Ee));
endfunction
