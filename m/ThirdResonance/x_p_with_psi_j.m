## 3 次共鳴の psi と j を x と x' に変換する

##== History
## 2008-03-07
## * initial implementaion
 
function x_p_array = x_p_with_psi_j(psi_j_list, track_rec, elem_name, pos_in_elem)
  sep_info = values_for_separatrix(track_rec);
  an_elem = element_with_name(track_rec, elem_name);
  s = an_elem.([pos_in_elem, "Position"]);
  theta = 2*pi*s/sep_info.circumference;
  phase_advance = an_elem.([pos_in_elem, "Phase"]).h;


  b = an_elem.([pos_in_elem, "Beta"]); # beta function
  a = an_elem.([pos_in_elem, "Twpar"]).h(2); # alpha of twiss parameter
  x_p_array = {};  
  for n = 1:length(psi_j_list)
  phi_list = psi_j_list{n}(:,1) + phase_advance...
          - sep_info.delta_tune*theta...
          - sep_info.xi/3;
    x_p = x_p_with_action_angle(phi_list(:), psi_j_list{n}(:,2), b.h, a);
    x_p_array{end+1} = x_p;
  endfor
endfunction
