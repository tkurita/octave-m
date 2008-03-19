## -*- texinfo -*-
## @deftypefn {Function File} {@var{hdiff} =} j_for_phi(@var{j})
## 
## Use evaluate j for given H and psi by __g_j_for_phi__.
## Pass to fsolve.
##
## @end deftypefn

##== History
## 2008-03-17
## * split from x_p_for_torous

function hdiff = j_for_phi(j)
  global __g_j_for_phi__;
  h = __g_j_for_phi__.h;
  psi = __g_j_for_phi__.psi;
  a_3n0 = __g_j_for_phi__.a_3n0;
  delta_tune = __g_j_for_phi__.delta_tune;
  hdiff = delta_tune*j ...
    + (j.^(3/2))*a_3n0.*cos(3*psi) ...
    - h;
endfunction