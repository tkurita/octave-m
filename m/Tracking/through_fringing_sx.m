##== History
## 2007-11-01
## * first implementaion


function particles = through_fringing_sx(elem_rec, particles)
  particles = sx_thin_kick(elem_rec, particles);
  particles = elem_rec.body.apply(elem_rec.body, particles);
  particles = sx_thin_kick(elem_rec, particles);
endfunction
  