## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} hit_checker_with_element(@var{arg})
##
## @end deftypefn

##== History
## 2008-03-24
## * first implementaion

function result = hit_checker_with_element(an_elem, name_suffix)
  if (nargin > 1)
    result.name = [an_elem.name,"_", name_suffix];
  else
    result.name = an_elem.name;
  end
  #result.name
  result.duct = an_elem.duct;
  result.track_info = "special";
  shape = an_elem.duct.shape;
  switch shape
    case "rect"
      result.apply = @through_hit_checker_rect;
    case "circle"
      result.apply = @through_hit_checker_circle;
    case "polygon"
      result.apply = @thorough_hit_checker_poly;
    otherwise
      error("%s is unknown shape.",shape);
  endswitch
  
  global _particle_history;
  _particle_history.hit.(result.name) = {};
endfunction