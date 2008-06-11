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
  persistent pre_hdiff = 1e-4;
  h = __g_j_for_phi__.h;
  psi = __g_j_for_phi__.psi;
  a_3n0 = __g_j_for_phi__.a_3n0;
  delta_tune = __g_j_for_phi__.delta_tune;
  hdiff = delta_tune*j ...
    + (j.^(3/2))*a_3n0.*cos(3*psi) ...
    - h;
  if (isfield(__g_j_for_phi__, "condition"))
    switch __g_j_for_phi__.condition
      case "large"
        if (j < __g_j_for_phi__.j0)
          hdiff = 2*hdiff;
          #h = -1*h;
          #hdiff = -1.01*pre_hdiff;
        endif
      case "small"
        if (j > __g_h_for_phi__.j0)
          hdiff = hdiff*2;
        endif
    endswitch
  endif
  pre_hdiff = hdiff;
#  printf("j :");disp(j);
#  printf("h :");disp(delta_tune*j + (j.^(3/2))*a_3n0.*cos(3*psi) );
#  printf("hdiff :");disp(hdiff);
endfunction