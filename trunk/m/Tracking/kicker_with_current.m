## Usage kicker_rec = kicker_with_value(name, value, cod_rec)
##
##== Paramers
## * value : setting of the kicker. It may be current [A].
##
##== Result
## kicker_rec
##    .kickVector : 6 elements vector

##== History
## 2007-10-03
## * initial implementaion

function kicker_rec = kicker_with_angle(name, kick_angle, lat_rec)
  kicker_rec = element_with_name(cod_rec.lattice, name)
  kicker_rec.apply = @kicker_kick;
  
  kick_angle = calcSteerAngle(kicker_rec, value, lat_rec.brho);
  if (strcmp(cod_rec.horv, "h"))
    a_vec = [0; kick_angle; 0; 0; 0; 0];
  elseif (strcmp(cod_rec.horv, "v"))
    a_vec = [0; 0; 0; 0; kick_angle; 0];
  else
    error("cod_rec.horv have invalid value");
  endif
  
  kicker_rec.kickVector = a_vec;
  
  kicker_rec.premat = DTmat(kicker_rec.len/2);
  kicker_rec.postmat = kicker_rec.premat;
endfunction