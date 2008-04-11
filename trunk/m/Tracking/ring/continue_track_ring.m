## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} continue_track_ring(@var{arg})
##
## @end deftypefn

##== History
##

function particle_hist = continue_track_ring(track_rec, particle_rec, previous_hist, n_rev)
  particle_rec.particles = previous_hist.(track_rec.start_elem){end};
  particle_hist = track_ring(track_rec, particle_rec, n_rev+1);
  for n = 1:length(track_rec.monitor)
    particle_hist.(track_rec.monitor{n}) = particle_hist.(track_rec.monitor{n})(2:end);
    particle_hist.revolution_number--;
  end
  
  if (!isfield(previous_hist, "beginning_revolution"))
    previous_hist.beginning_revolution = 1;
  end
  particle_hist.beginning_revolution =  previous_hist.beginning_revolution...
                                        + previous_hist.revolution_number;
endfunction