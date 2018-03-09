## -- Function File :
##   [eArea,eArea2,deltaEmax,phi1] = rfbucket_area(
##                                vlist, nM, Ee, eta, h, phi_s, C)
## == parameters : 
## vlist : RF Voltage Pattern, must be (voltage * charge state)
## phi_s : phase angle of synchronus particle
## Ee : Total energy
## nM : mass number of the particle
## C : シンクロトロンの周長
## 
## == results : 
## eArea : RF Bucket Area in deltaE-phi coordinate [eV]
## eArea2 : RF Bucket Area in deltaE/(h omega_rev) -phi coordinate [ev sec]
## deltaEmax : bucket height [eV]
## phi1 : unstable fixed point

##== History
## 2014-04-11
## * support new physical_constant
## 2010-12-21
## * renamed from RFBucketEArea

function [eArea,eArea2,deltaEmax,phi1] = rfbucket_area(vlist, particle, Ee, eta, h, phi_s,C)
  # particle = 1
  # phi_s = ps;
  
  lv = physical_constant("speed of light in vacuum"); #光速

  for n = 1:length(phi_s)
    # n = 1
    fs = phi_s(n);
    [alphaArea(n),yHeight(n), phi1(n)] = rfbucket_size(fs);
  endfor
  alphaArea = alphaArea';
  yHeight = yHeight';
  phi1 = phi1';

  m0c2 = mass_energy(particle)*1e6; # [eV]
  beta2 = 1 - (m0c2^2)./(Ee.^2);
  eArea = 16.*sqrt(vlist .* beta2 .*Ee./(2*pi*h.*abs(eta))).*alphaArea;
##  omega_rev = 2*pi.*sqrt(beta2).*lv./C;
##  eArea2 = eArea./(h .*omega_rev); 
  eArea2 = 16.*(C/lv) .* sqrt(vlist .* Ee./((2*pi*h)^3.*abs(eta))).*alphaArea;
  deltaEmax = sqrt(vlist .* beta2./h) .* yHeight .*sqrt(abs(Ee./(pi.*eta)));
endfunction
