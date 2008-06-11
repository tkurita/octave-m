## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} func_name(@var{arg})
##
## @end deftypefn

##== History
## 2008-03-17
## * first implementaion
## * not tested.

function result = x_p_with_psi_h(psi, h, track_rec, elem_name, pos_in_elem)
  sepinfo = values_for_separatrix(track_rec);
  global __g_j_for_phi__;
  __g_j_for_phi__ = setfields(sepinfo, "h", h);
  __g_j_for_phi__ = setfields(__g_j_for_phi__, "psi", psi);
  j0 = h/sepinfo.delta_tune;
  j = fsolve(@j_for_phi, j0);
  x_p_list = x_p_with_psi_j({[psi, j]}, track_rec, elem_name, pos_in_elem);
endfunction