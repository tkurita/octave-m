function particle_rec = track_course(a_course, initial_particles, step)
  position_list = {0};
  particle_list = {initial_particle};
  total_len = 0;
  for n = 1:length(a_course)
    s = 0;
    particles_in = particle_list{end};
    while (an_elem.len > s)
      s += step;
      a_tracker = tracker_at_position(an_elem, s);
      particle_list{end+1} = a_tracker.apply(a_tracker, particles_in);
      position_list{end+1} = total_len + s;
    endwhile
    a_tracker = tracker_at_position(an_elem, an_elem.len);
    particle_list{end+1} = a_tracker.apply(a_tracker, particles_in);
    total_len += an_elem.len;
    position_list{end+1} = total_len;
  endfor
  particle_rec = struct("postions", postion_list, "particles", particle_list);
endfunction
