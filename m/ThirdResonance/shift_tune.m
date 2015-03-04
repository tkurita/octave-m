function track_rec = shift_tune(track_rec, delta_nu)
  track_rec.tune.h = track_rec.tune.h + delta_nu.h;
  track_rec.tune.v = track_rec.tune.v + delta_nu.v;
endfunction
