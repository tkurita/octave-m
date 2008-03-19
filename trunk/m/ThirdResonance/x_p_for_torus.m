## ハミルトニアンが一定となる x と x' の線を計算する。
## h_list で 求めるハミルトニアンを与える。
## たぶん h_list は正式には、周長×ハミルトニアン だと思う

##== History
## 2008-03-07
## * initial implementation

function x_p_list = x_p_for_torus(h_list, track_rec, elem_name, pos_in_elem, psi_list)
  global __g_j_for_phi__;
  sepinfo = values_for_separatrix(track_rec);
  if (nargin < 5)
    psi_list = 0:(2*pi/360):2*pi;
  end
  
  psi_j_list = {};
  
  for h = h_list;
    __g_j_for_phi__ = setfields(sepinfo, "h", h);
    j_buffer = [];
    psi_buffer = [];
    #h
    for psi = psi_list
      #psi
      __g_j_for_phi__ = setfields(__g_j_for_phi__, "psi", psi);
      j0 = h/sepinfo.delta_tune;
      try
        j_buffer(end+1) = fsolve(@j_for_phi, j0);      
      catch
        if (length(j_buffer) > 0)
          psi_j_list{end+1} = [psi_buffer(:), j_buffer(:)];
        endif
        j_buffer = [];
        psi_buffer = [];
        continue;
      end_try_catch
      psi_buffer(end+1) = psi;
    endfor
    #j_mat(:,end+1) = j_list(:);
    if (length(j_buffer) > 0)
      psi_j_list{end+1} = [psi_buffer(:), j_buffer(:)];
    endif
  endfor
  
  x_p_list = x_p_with_psi_j(psi_j_list, track_rec, elem_name, pos_in_elem);
endfunction

