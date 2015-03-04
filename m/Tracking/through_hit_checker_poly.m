## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} through_hit_checker_poly(@var{arg})
##
## @end deftypefn

##== History
## 2008-04-23
## * initial implementation

function particles = through_hit_checker_poly(an_elem, particles)
  global _particle_history;
  global __revolution_number__;
  global __particle_id__;
  #"through_hit_checker"
  x_list = particles(1,:);
  y_list = particles(4,:);
  
  hit_flag = inpolygon(x_list, y_list, an_elem.duct.x, an_elem.duct.y);
  
  
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