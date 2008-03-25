## Usage : out_particles = through_monitor(mat_rec, in_particles)
##    out_particles = mat_rec.mat * in_particles;

##== History
## 2007-10-03
## * initial implementaion

function out_particles = through_monitor(mat_rec, in_particles)
  # in_particles = particles;
  # mat_rec = element_with_name(span_array, "ESD")
  global _particle_history;
  global __revolution_number__;
  #  _particle_history.(mat_rec.name)(:,end+1:end+columns(in_particles))...
  #                                             = in_particles;
  _particle_history.(mat_rec.name){__revolution_number__} = in_particles;
  
  out_particles = mat_rec.mat * in_particles;
endfunction
