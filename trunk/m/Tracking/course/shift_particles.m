function out_particles = shift_particles(offset_prop, in_particles)
  global __shift_vector;
  shift_vector = repmat(offset_prop.vector, 1, size(in_particles)(2));
  __shift_vector = __shift_vector + shift_vector;
  out_particles = in_particles + shift_vector;
endfunction