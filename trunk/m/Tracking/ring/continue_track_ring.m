## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} continue_track_ring(@var{arg})
##
## @end deftypefn

##== History
##

function particle_hist = continue_track_ring(track_rec, particle_rec, previous_hist, n_rev)
  particle_rec.particles = previous_hist.(track_rec.start_elem){end};
  particle_hist = track_ring(track_rec, particle_rec, n_rev+1);
  for n = 1:length(track_rec.monitors)
    particle_hist.(track_rec.monitors{n}) = particle_hist.(track_rec.monitors{n})(2:end);
    particle_hist.revolution_number--;
  end
  
  if (!isfield(previous_hist, "beginning_revolution"))
    previous_hist.beginning_revolution = 1;
  end
  particle_hist.beginning_revolution =  previous_hist.beginning_revolution...
                                        + previous_hist.revolution_number;

  for [val, key] = particle_hist.hit
    if (!isempty(val))
      if (val{1}.n_rev == 1)
        val = val(2:end);
      endif
      for (n = 1:length(val))
        val{n}.n_rev += (particle_hist.beginning_revolution-2);
      endfor
      particle_hist.hit.(key) = val;
    endif
  endfor

endfunction