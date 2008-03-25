## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} subtract_particles(@var{particles_a}, @{particles_b}, ...)
##
## @var{particles_a} - @var{particles_b} - ...
## 
## @table @code
## @item @var{particles_a}
## The output of distill_history
##
## @item @var{particles_b}
## The output of distill_history or distill_lasts
##
## @end table
## 
## @end deftypefn

##== History
## 2008-03-24
## * initial implementaion

function particles_a = subtract_particles(particles_a, varargin)
  if (!isfield(particles_a, "id"))
    particles_a.id = 1:length(particles_a.h);
  end
  
  for n = 1:length(varargin)
    particles_b = varargin{n};
    [c, ia, ib] = intersect(particles_a.id, particles_b.id);
    for [val, key] = particles_a
      #key
      switch key
        case "id"
          #particles_a.id = particles_a.id(ia);
          particles_a.id(ia) = [];
        case "n_rev"
          #particles_a.(key) = val(!ia);
          particles_a.(key)(ia) = [];
        otherwise
          if (iscell(val))
#            for m = 1:length(particles_a.(key))
#              particles_a.(key){m} = particles_a.(key){m}(:,ia) = [];
#            end
            particles_a.(key)(ia) = []
          else
            #particles_a.(key) = val(!ia, :);
            particles_a.(key)(ia, :) = [];
          end
      endswitch
    end
  endfor
endfunction