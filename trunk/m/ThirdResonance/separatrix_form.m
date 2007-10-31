## -*- texinfo -*-
## @deftypefn {Function File} {@var{xy_points} =} separatrix_form(@var{track_rec}, @var{elem_name}, @var{pos_in_elem})
##
## Return fixed points of third sepatartix at the location specified with with @var{elem_name} and @var{pos_in_elem}. For the plotting, 4 xy-points is returnd where first xy-point is equal to last xy-point.
##
## @var{track_rec} must have following fields.
## @table @code
## @item sextupoles.strength
## @item lattice
## @item tune
## @end table
## 
## @var{elem_name} : name of the element.
## 
## @var{pos_in_elem} : position in the element. "entrance", "center" or "exit"
##
## @end deftypefn

##== History
## 2007-10-16
## * initial implementaion

function xy_points = separatrix_form(track_rec, elem_name, pos_in_elem)
  sep_info = prepare_for_separatrix(track_rec);
  an_elem = element_with_name(track_rec, elem_name);
  phase_advance = an_elem.([pos_in_elem, "Phase"]).h;
  s = an_elem.([pos_in_elem, "Position"]);
  if (sep_info.delta_tune > 0) 
    phi_fp = [pi/3, pi, 5*pi/3];
  else
    phi_fp = [0, 2*pi/3, 4*pi/3];
  endif
  
  phi = phi_fp + phase_advance...
  - sep_info.delta_tune*2*pi*s/sep_info.circumference...
  - sep_info.coupling_angle/3;
  beta_f = an_elem.([pos_in_elem,"Beta"]).h;
  alpha_f = an_elem.centerTwpar.h(2);
  J = (2*sep_info.delta_tune/(3*sep_info.a_3n0))^2;
  x = sqrt(2*J*beta_f).*cos(phi);
  xprime = -sqrt(2*J/beta_f).*(alpha_f.*cos(phi) + sin(phi));
  xy_points = [x; xprime]'*1000;
  xy_points(end+1,:) = xy_points(1,:);
endfunction
