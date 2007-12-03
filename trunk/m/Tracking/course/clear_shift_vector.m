function out_particles = clear_shift_vector(unshifter, in_particles)
  global __shift_vector 
  out_particles = in_particles - __shift_vector;
  __shift_vector = zeros(size(in_particles));
end