##== History
## 2008-06-18
## * obsolete. Use initial_twiss_parameters
##

function twPcosMu = twissParameter(fullMatrix)
  warning("twissParameter is deprecated. Use initial_twiss_parameters");
  cosmu = (fullMatrix(1,1)+fullMatrix(2,2))/2;
  
  if fullMatrix(1,2) >= 0
    sinmu = sqrt(1-cosmu^2);
  else
    sinmu = -sqrt(1-cosmu^2);
  endif
  
  beta0 = fullMatrix(1,2)/sinmu;
  
  alpha0 = (fullMatrix(1,1)-fullMatrix(2,2))/(2*sinmu);
  
  gamma0 = (1+alpha0^2)/beta0;
  
  twPcosMu.twp = [beta0;alpha0;gamma0];
  twPcosMu.cosmu = cosmu;
endfunction