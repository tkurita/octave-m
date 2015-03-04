## -*- texinfo -*-
## @deftypefn {Function File} {@var{particle_rec} =} generate_particles3(@var{particle_rec}, @var{track_rec})
## @deftypefnx {Function File} {@var{particle_rec} =} generate_particles3(@var{particle_rec}, @var{track_rec}, @var{element_info})
##
## generate particles inside the separatrix of the third-order respnace
## 
## @end deftypefn

##== History
## 2008-03-17
## * first implementaion

function particle_rec = generate_particles3(particle_rec, track_rec, element_info)
  n = particle_rec.num;
  
  if (nargin < 3)
    if (isfield(track_rec, "start_elem"))
      an_elem = element_with_name(track_rec, track_rec.start_elem);
      element_info = element_info_at(an_elem, "entrance");
    else
      element_info = element_info_at(track_rec.lattice{end}, "exit");
    end
  end
  
  ## Horizontal
  sep_info = values_for_separatrix(track_rec);
  [delta_tune, J, a_3n0, psi] = ...
                 getfields(sep_info, "delta_tune", "J","a_3n0", "psi");
  psi = psi(1);
  h_fp = delta_tune*J + (J.^(3/2))*a_3n0.*cos(3*psi);
  h_r = h_fp * particle_rec.h_reduction;
  psi = rand(1,n)*2*pi;
  if (isfield(particle_rec, "filled") && particle_rec.filled)
    h_r = rand(1,n)*h_r;
  else
    h_r = h_r*ones(n,1);
  endif
#  h_r
  j = [];
  global __g_j_for_phi__;
  for l = 1:n
    __g_j_for_phi__ = setfields(sep_info, "h", h_r(l));
    __g_j_for_phi__ = setfields(__g_j_for_phi__, "psi", psi(l));
    j0 = h_r(l)/sep_info.delta_tune;
    j(l) = fsolve(@j_for_phi, j0);
  end
  phi = phi_with_psi(psi, element_info, sep_info);
  x_p = x_p_with_action_angle(phi, j, element_info.twpar.h(1), element_info.twpar.h(2));
  #x_p
  ## Vertical
  emy = particle_rec.em.y;
  if (isfield(particle_rec, "filled") && particle_rec.filled)
    emy = rand(1,n)*emy;
  end
  phi_y = rand(1,n)*2*pi;
  b = element_info.twpar.v(1);
  a = element_info.twpar.v(2);
  y = sqrt(emy.*b).*cos(phi_y);
  yprime = -sqrt(emy./b).*(a.*cos(phi_y) + sin(phi_y) );

  ## momentum error
  p_error = 0;
  if (isfield(particle_rec, "pError"))
    p_error = particle_rec.pError;
  endif
  p_error_vec = repmat(p_error,1,n);

  ## Build Result
  particle_rec.particles = [x_p'; p_error_vec; y; yprime ;p_error_vec];
endfunction

