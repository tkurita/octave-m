## -*- texinfo -*-
## @deftypefn {Function File} {} through_hit_checker_circle(@var{arg})
##
## @end deftypefn

##== History
## 2008-04-17
## * initial implementaion

function particles = through_hit_checker_circle(an_elem, particles)
  global _particle_history;
  global __revolution_number__;
  global __particle_id__;
  x_list = particles(1,:);
  y_list = particles(4,:);
  r2_list = x_list.^2 + y_list.^2;

  hit_flag =  r2_list >= an_elem.duct.radius;
  if (any(hit_flag))
    hit_mat = [(x_list > an_elem.duct.xmax);...
               (x_list < an_elem.duct.xmin);...
               (y_list > an_elem.duct.ymax);...
               (y_list < an_elem.duct.ymin)];
               
    _particle_history.hit.(an_elem.name){end+1}...
                  = struct("n_rev", __revolution_number__ ...
                          , "id", __particle_id__(hit_flag) ...
                          , "particles", particles(:, hit_flag)...
                          , "flags", hit_mat(:, hit_flag) );
    
    particles(:, hit_flag) = NaN;
  end
endfunction