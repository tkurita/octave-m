##== History
## 2007-10-03
## * initial implementaion

function out_particles = kicker_kick(kicker_rec, in_particles)
  out_particles = kicker_rec.premat * in_particles;
  out_particles = kicker_rec.postmat...
    * (out_particles + repmat(kicker_rec.kickVector, 1, size(in_particles)(2)));
endfunction
