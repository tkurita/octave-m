## -*- texinfo -*-
## @deftypefn {Function File} {@var{sepatartix_info} =} prepare_for_separatrix(@var{track_rec})
## Return pre-parameters for calculation of third resonance separatrix.
##
## 
## 
## The result has following fields.
##
## @table @code
## @item delta_tune
## difference of resonance tune and particle tune.
## @code{delta_tune = n0/3 - tune}
##
## @item a_3n0
## 
## @item circumference
## The circumference of the ring.
##
## @end table
## @end deftypefn

##== History
## 2007-10-16
## * initial implementation
function separatrix_info = prepare_for_separatrix(track_rec)
  sx_names = value_for_keypath(track_rec.sextupoles, "name", true);
  sx_strength = value_for_keypath(track_rec.sextupoles, "strength");
  sx_array = element_with_name(track_rec, sx_names);
  sx_positions = value_for_keypath(sx_array, "centerPosition");
  circumference = circumference(track_rec);
  sx_theta = 2*pi.*sx_positions./circumference;
  sx_beta = value_for_keypath(sx_array, "centerBeta.h");
  sx_phase = value_for_keypath(sx_array, "centerPhase.h");
  tune = track_rec.tune.h;
  n0 = find_n0(tune, 3);
  sx_beta_32 = sx_beta.^(3/2);
  b = sx_beta_32.*sx_strength.*exp(i*(3.*sx_phase - (3*tune - n0).*sx_theta));
  coupling_term = (sqrt(2)/(24*pi))*sum(b);
  a_3n0 = abs(coupling_term);
  coupling_angle = angle(coupling_term);
  delta_tune = tune - n0/3;
  
  # detuning factor
  detune_xx = 0;
  for n = 1:length(sx_strength)
    del_phase = abs(sx_phase(n) - sx_phase);
    detune_xx += (sx_strength(n)*sx_strength).*(sx_beta_32(n).*sx_beta_32)...
    .*(cos(3*(pi*tune-del_phase))/sin(3*pi*tune) + 3*cos(pi*tune - del_phase)/sin(pi*tune));
  endfor
  detune_xx = (1/(64*pi))*sum(detune_xx);
  
  # build result
  separatrix_info = build_struct(delta_tune, a_3n0, coupling_angle, circumference, detune_xx);
endfunction