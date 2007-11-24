function out_particles = add_vector(offset_prop, in_particles)
  out_particles = in_particles + repmat(kicker_rec.vector, 1, size(in_particles)(2));
endfunction