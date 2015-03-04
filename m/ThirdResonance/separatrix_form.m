## -*- texinfo -*-
## @deftypefn {Function File} {[@var{fixed_points}, @var{sep_info}] =} separatrix_form(@var{track_rec}, @var{elem_name}, @var{pos_in_elem})
##
## Return fixed points of third sepatartix at the location specified with with @var{elem_name} and @var{pos_in_elem}. For the plotting, 4 xy-points is returnd where first xy-point is equal to last xy-point.
##
## @var{track_rec} can have following fields.
## @table @code
## @item sextupoles.strength
## @item lattice
## @item tune
## @item bm_sx
## optional.
## @end table
## 
## @var{elem_name} : name of the element.
## 
## @var{pos_in_elem} : position in the element. "entrance", "center" or "exit"
##
## Results:
##
## @table @code
## @item @var{fiexed_points}
## The coordinates of fiexd points on the phase space in the unit of [mm] and [mrad].
## @item @var{sep_info}
## A collection of values related with the 3rd resonance separatrix.
## @end table
##
## @var{sep_info} has following fields.
##
## @table @code
## @item J
## @item psi
## @item theta
## @item xi
## @item phi
## @item phase_advance
## @item delta_tune
## @item tune
## @item a_3n0
## @item circumference
## @item fixed_points
## The coordinates of fiexd points on the phase space in the unit of [m] and [rad].
## @end table
##
## @end deftypefn

#shareTerm /Users/tkurita/WorkSpace/シンクロトロン/2007.10 Tracking/extraction_tracking2/extraction_tracking2.m

##== History
## 2008-03-17
## * use latest values_for_separatrix
##
## 2008-02-25
## * fix a bug that "alpha_f" is not considered an argument "pos_in_elem".
## * fixed points without 1000 factor as second return value.
## 
## 2008-02-21
## * rename sep_info.coupling_angle to sep_info.xi
## 
## 2008-02-09
## * use values_for_separatrix instead of prepare_for_separatrix
## 
## 2007-11-02
## * add support bm_sx
##
## 2007-10-16
## * initial implementaion

function [xy_points_1000, sep_info] = separatrix_form(track_rec, elem_name, pos_in_elem)
  sep_info = values_for_separatrix(track_rec);
  an_elem = element_with_name(track_rec, elem_name);
  phase_advance = an_elem.([pos_in_elem, "Phase"]).h;
  s = an_elem.([pos_in_elem, "Position"]);  
#  if (sep_info.delta_tune > 0) 
#    psi_fp = [pi/3, pi, 5*pi/3];
#  else
#    psi_fp = [0, 2*pi/3, 4*pi/3];
#  endif
  psi_fp = sep_info.psi;
  theta = 2*pi*s/sep_info.circumference;
#  psi_fp
  phi = psi_fp + phase_advance...
    - sep_info.delta_tune*theta...
    - sep_info.xi/3;
  #phi
  beta_f = an_elem.([pos_in_elem,"Beta"]).h;
  #beta_f
  #alpha_f = an_elem.centerTwpar.h(2);
  alpha_f = an_elem.([pos_in_elem, "Twpar"]).h(2);
  #alpha_f
  #J = (2*sep_info.delta_tune/(3*sep_info.a_3n0))^2;
  #J
  J = sep_info.J;
  x = sqrt(2*J*beta_f).*cos(phi);
  xprime = -sqrt(2*J/beta_f).*(alpha_f.*cos(phi) + sin(phi));
  xy_points = [x; xprime]';
  xy_points(end+1, :) = xy_points(1,:);
  xy_points_1000 = xy_points*1000;
  sep_info.phi = phi;
  sep_info.theta = theta;
  sep_info.phase_advance = phase_advance;
  sep_info.fixed_points = xy_points;
endfunction
