## Usage kicker_rec = kicker_with_angle(name, kick_angle, cod_rec)
##
##== Paramers
##
##== Result
## kicker_rec
##    .kickVector : 6 elements vector

##== History
## 2007-10-03
## * initial implementaion

function kicker_rec = kicker_with_angle(name, kick_angle, cod_rec)
  kicker_rec = element_with_name(cod_rec.lattice, name);
  kicker_rec.apply = @kicker_kick;
  
  if (strcmp(cod_rec.horv, "h"))
    a_vec = [0; kick_angle; 0; 0; 0; 0];
  elseif (strcmp(cod_rec.horv, "v"))
    a_vec = [0; 0; 0; 0; kick_angle; 0];
  else
    error("cod_rec.horv have invalid value");
  endif
  
  kicker_rec.track_info = "special";
  kicker_rec.kickVector = a_vec;
  if (isBendingMagnet(kicker_rec))
    #kicker_rec
    kicker_rec.premat = [kicker_rec.mat_half.h, zeros(3);...
                        zeros(3), kicker_rec.mat_half.v];
    #kicker_rec.postmat = postmat_BM(kicker_rec);
    kicker_rec.postmat = [kicker_rec.mat_rest.h, zeros(3);...
                          zeros(3), kicker_rec.mat_rest.v];
  else
    a_mat = DTmat(kicker_rec.len/2);
    kicker_rec.premat = [a_mat, zeros(3); zeros(3), a_mat];
    kicker_rec.postmat = kicker_rec.premat;
  endif
  
endfunction

function result = postmat_BM(element)
  radius = element.radius;
  bmangle = element.bmangle;
  edgeangle = element.edgeangle;
  
  hasEfflen = isfield(element, "efflen"); 
  if (hasEfflen)
    len = element.efflen;
    radius = element.efflen/bmangle;
    dl = (element.efflen - element.len)/2;
  else
    len = element.len;
  endif
  
  mat_h = BME_H(radius, edgeangle) * BMHmat(radius, bmangle/2, 0);
  mat_v =  BME_V(radius,edgeangle) * DTmat(len/2);
  
  if (hasEfflen)
    back_dt = DTmat(-dl);
    mat_h = back_dt * mat_h;
    mat_v = back_dt * mat_v;
  endif
  
  result = [mat_h, zeros(3); zeros(3), mat_v];
endfunction
