## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} through_rfk(@var{rfk_rec}, @var{particles})
## 
## Evaluate particles throught the RF Kicker @var{rfk_rec}.
##
## @end deftypefn

##== History
## 2008-03-17
## * first implementaion

function result = through_rfk(rfk_rec, particles)
  global __revolution_number__;
  particles = rfk_rec.premat*particles;
  rfkicks = zeros(6, rfk_rec.n_particle);
  #rfk_rec.kick_angle(__revolution_number__)
  kick_angle_len = columns(rfk_rec.kick_angle);
  kick_ind = __revolution_number__;
  while (kick_ind > kick_angle_len)
    kick_ind = kick_ind - kick_angle_len
  end

  rfkicks(2,:) = ones(1,rfk_rec.n_particle)*rfk_rec.kick_angle(kick_ind);
  result = rfk_rec.postmat * (particles + rfkicks);
endfunction