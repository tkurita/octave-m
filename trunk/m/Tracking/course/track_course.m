## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} track_course(@var{elements}, @var{initial_particles}, @var{step})
##
## Parameters
##
## @table @code
## @item @var{elements}
## A cell array of Beam Optics Objects making up the course.
## The order is upper stream to down stream.
## @item @var{initial_particles}
## Initial particles. (number of particles)*6 matrix.
##
## @end table
##
## Result
##
## @table @code
## @item hit_flag(1,:)
## horizontal
## @item hit_flag(2,:)
## vertical
## @end table
## 
## @end deftypefn

##== History
## 2007-11-27
## * initial implementaion

function particle_rec = track_course(a_course, initial_particles, step)
  position_list = [0];
  particle_list = {initial_particles};
  total_len = 0;
  global __shift_vector;
  __shift_vector = zeros(size(initial_particles));
  hit_flag = zeros(2, columns(initial_particles));
  
  particles_in = initial_particles;
  for n = 1:length(a_course)
    s = step;
    an_elem = a_course{n};
    while (an_elem.len > s)
      a_tracker = tracker_at_position(an_elem, s);
      particles = a_tracker.apply(a_tracker, particles_in);
      particle_list{end+1} = unshift_particles(particles, s);
      position_list(end+1) = total_len + s;
      s += step;
      if (isfield(an_elem, "duct"))
        hit_flag = hit_flag | check_hit(particle_list{end}, an_elem);
      end
    endwhile
    a_tracker = tracker_at_position(an_elem, an_elem.len);
    particles_in = a_tracker.apply(a_tracker, particles_in);
    particle_list{end+1} = unshift_particles(particles_in, an_elem.len);
    update_shift_vector(s);
    total_len += an_elem.len;
    position_list(end+1) = total_len;
    if (isfield(an_elem, "duct"))
        hit_flag = hit_flag | check_hit(particle_list{end}, an_elem);
    end
  endfor
  
  particle_rec.positions = position_list;
  particle_rec.particles = particle_list;
  particle_rec.n = columns(initial_particles);
  particle_rec.hit_flag = hit_flag;
endfunction

function update_shift_vector(s)
  global __shift_vector;
  a_dt = DT(s, "");
  __shift_vector = mat_with_element(a_dt) * __shift_vector;
end

function out_particles = unshift_particles(in_particles, s)
  global __shift_vector;
  a_dt = DT(s, "");
  out_particles = in_particles - (mat_with_element(a_dt) * __shift_vector);
end 

function hit_flag = check_hit(particles, an_elem)
  x_list = particles(1,:);
  y_list = particles(4,:);
  hit_flag =[(x_list > an_elem.duct.xmax) | (x_list < an_elem.duct.xmin);
             (y_list > an_elem.duct.ymax) | (y_list < an_elem.duct.ymin)] ;
end