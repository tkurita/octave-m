## -*- texinfo -*-
## @deftypefn {Function File} {} j_after_3turns(@var{phi}, @var{j}, @var{sep_info}, @var{h})
##
## Evaluate action value J after three turns
## @table @code
## @item @var{sep_info}
## @item @var{h}
## hamiltonian
##
## @end table
##
## @end deftypefn

##== History
## 2008-05-23
## * initial implementation

function phi_j_3 = phij_after_3turns(phi_j, sep_info, h)
  global __g_j_for_phi__;
  __g_j_for_phi__ = sep_info;
  __g_j_for_phi__.h = h;
  phi3 = phi_j(:,1) +  (3*sep_info.tune-5)*(2*pi);
  psi3 = phi3 - ...
        (sep_info.phase_advance - sep_info.delta_tune*sep_info.theta - sep_info.xi/3);
  j3 = [];
  #clear(j_for_phi);
  __g_j_for_phi__.condition = "large";
  for n = 1:length(psi3)
    __g_j_for_phi__.psi = psi3(n);
    __g_j_for_phi__.j0 = phi_j(n,2);
    j3(end+1) = fsolve(@j_for_phi, phi_j(n,2)*10000000*n);
  endfor
  phi_j_3 = [phi3(:), j3(:)];
endfunction