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
  n = __revolution_number__ - (_particle_history.beginning_revolution-1);
  _particle_history.monitors.(mat_rec.name){n} = in_particles;
  
  out_particles = mat_rec.mat * in_particles;
endfunction
