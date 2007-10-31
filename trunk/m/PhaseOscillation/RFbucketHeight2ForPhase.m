## usage : [deltaE,delEE,delpp] = RFbucketHeight2ForPhase(
##						  V, nM, Ee, eta, h, phi_s, C, rV, phi2 , phi)
## parameters : 
## V : RF Voltage Pattern, must be (voltage * charge state)
## phi_s : phase angle of synchronus particle
## Ee : Total energy
## nM : mass number of the particle
## C : シンクロトロンの周長
## rV : 基本波と高調波の電圧比
## phi2 : 基本波と高調波の位相オフセット。
##        基本波と高調波の位相差は -phi_s + phi2 になる。
## phi : この位相でのbucket height を計算する。 
## 
## results : 
## deltaE : bucket height at phase : phi
## delEE : delta E/E total energy spread correspoding to deltaE
## delpp : delta p/p momentum spread coresponding to deltaE

function [deltaE,delEE,delpp] = RFbucketHeight2ForPhase(...
						  V, nM, Ee, eta, h, phi_s, C, rV, phi2 , phi)
  global proton_eV;
  global lv;

  bucketPot_c = relativeBucketPotential(rV, phi_s, phi2, phi );
  bucketPot_s = relativeBucketPotential(rV, phi_s, phi2, phi_s );

  m0c2 = nM*proton_eV;
  beta2 = 1 - (m0c2^2)./(Ee.^2);
  
  bucketFactor = (Ee.*V.*beta2)./(pi.*eta.*h);
  
  deltaE = sqrt(abs(bucketFactor.*(bucketPot_c - bucketPot_s)));
  delEE = deltaE/Ee;
  delpp = delEE/beta2;
endfunction

function u = relativeBucketPotential(rV, phi_s, phi2, phi )
  u = cos(phi) + phi.*sin(phi_s)...
	  + (rV/2)*cos(2*phi-phi_s + phi2) + rV*phi*sin(phi_s + phi2);
end