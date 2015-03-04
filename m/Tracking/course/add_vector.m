function out_particles = add_vector(offset_prop, in_particles)
  shift_vector = repmat(offset_prop.vector, 1, columns(in_particles));
  out_particles = in_particles + shift_vector;
endfunction