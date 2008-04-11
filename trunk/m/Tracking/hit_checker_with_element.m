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
  result.apply = @through_hit_checker;
  
  global _particle_history;
  _particle_history.hit.(result.name) = {};
endfunction