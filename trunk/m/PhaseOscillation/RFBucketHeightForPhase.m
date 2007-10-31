## usage : [deltaE,delEE,delpp] = RFbucketHeightForPhase(
##                                V, nM, Ee, eta, h, phi_s, C, phi)
## parameters : 
## V : RF Voltage Pattern, must be (voltage * charge state)
## phi_s : phase angle of synchronus particle
## Ee : Total energy
## nM : mass number of the particle
## C : シンクロトロンの周長
## phi : この位相でのbucket height を計算する。 
## 
## results : 
## deltaE : bucket height at phase : phi
## delEE : delta E/E total energy spread correspoding to deltaE
## delpp : delta p/p momentum spread coresponding to deltaE


function [deltaE,delEE,delpp] = RFbucketHeightForPhase(V, nM, Ee, eta, h, phi_s, C, phi)
  global proton_eV;
  global lv;

  bucketPot_c = cos(phi) + phi.*sin(phi_s);
  bucketPot_s = cos(phi_s) + phi.*sin(phi_s);

  m0c2 = nM*proton_eV;
  beta2 = 1 - (m0c2^2)./(Ee.^2);
  
  bucketFactor = (Ee.*V.*beta2)./(pi.*eta.*h);
  
  deltaE = sqrt(abs(bucketFactor.*(bucketPot_c - bucketPot_s)));
  delEE = deltaE/Ee;
  delpp = delEE/beta2;
endfunction
