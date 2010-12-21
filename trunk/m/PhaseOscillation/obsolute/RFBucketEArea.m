## usage : [eArea,eArea2,deltaEmax,phi1] = RFbucketEArea(
##                                vList, nM, Ee, eta, h, phi_s, C)
## parameters : 
## vList : RF Voltage Pattern, must be (voltage * charge state)
## phi_s : phase angle of synchronus particle
## Ee : Total energy
## nM : mass number of the particle
## C : シンクロトロンの周長
## 
## results : 
## eArea : RF Bucket Area in deltaE-phi coordinate [eV]
## eArea2 : RF Bucket Area in deltaE/(h omega_rev) -phi coordinate [ev sec]
## deltaEmax : bucket height [eV]
## phi1 : unstable fixed point

##== History
## 2010-12-21
## * 
function [eArea,eArea2,deltaEmax,phi1] = RFbucketEArea(vList, particle, Ee, eta, h, phi_s,C)
  warning("Use rfbucket_area instead of RFbucketEArea");
  lv = physical_constant("SPEED_OF_LIGHT_IN_VACUUM"); #光速

  for n = 1:length(phi_s)
	fs = phi_s(n);
	[alphaArea(n),yHeight(n), phi1(n)] = calcBucketSize(fs);
  endfor

  m0c2 = mass_energy(particle)*1e6; # [eV]
  beta2 = 1 - (m0c2^2)./(Ee.^2);
  eArea = 16.*sqrt(vList .* beta2 .*Ee./(2*pi*h.*abs(eta))).*alphaArea;
##  omega_rev = 2*pi.*sqrt(beta2).*lv./C;
##  eArea2 = eArea./(h .*omega_rev); 
  eArea2 = 16.*(C/lv) .* sqrt(vList .* Ee./((2*pi*h)^3.*abs(eta))).*alphaArea;
  deltaEmax = sqrt(vList .* beta2./h) .* yHeight .*sqrt(abs(Ee./(pi.*eta)));
endfunction
