function out_particles = add_vector(offset_prop, in_particles)
  shift_vector = repmat(offset_prop.vector, 1, size(in_particles)(2));
  out_particles = in_particles + shift_vector;
endfunction