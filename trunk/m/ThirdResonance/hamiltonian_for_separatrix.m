## -*- texinfo -*-
## @deftypefn {Function File} {} hamiltonian_for_separatrix(@var{track_rec})
##
## Obtaion hamiltonian for the separatrix of third resonance.
##
## @end deftypefn

##== History
## 2008-03-17
## * first implementaion

function result = hamiltonian_for_separatrix(track_rec)
  sep_info = values_for_separatrix(track_rec);
  [delta_tune, J, a_3n0, psi] = ...
                   getfields(sep_info, "delta_tune", "J","a_3n0", "psi");
  psi = psi(1);
  result = delta_tune*J + (J.^(3/2))*a_3n0.*cos(3*psi);
endfunction