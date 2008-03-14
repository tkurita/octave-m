
##== History
## 2008-03-11
## *tune can be scalar
##
## 2008-02-20
## * initial implementation

function [h, phi_j] = hamiltonian_3reso(particle_hists, tune, track_rec, elem_name, pos_in_elem)
  if (isscalar(tune))
    tune = tune*ones(size(particle_hists));
  end

  sep_info = values_for_separatrix(track_rec, tune);
  an_elem = element_with_name(track_rec, elem_name);
  b = an_elem.([pos_in_elem, "Beta"]); # beta function
  a = an_elem.([pos_in_elem, "Twpar"]).h(2); # alpha of twiss parameter
  s = an_elem.([pos_in_elem, "Position"]);
  theta = 2*pi*s/sep_info.circumference;
  
  if (iscell(particle_hists))
    n_particles = length(particle_hists);
  else
    particle_hists = {particle_hists};
    n_particles = 1;
  endif
  
  phase_advance = an_elem.([pos_in_elem, "Phase"]).h;
  for n = 1:n_particles
    particles = particle_hists{n};
    phi_j{n} = action_angle(particles, b.h, a);
    k = phi_j{n}(:,2);
#    phi1 = phi_j{n}(:,1) - an_elem.entrancePhase.h + sep_info.tune(n) * theta;
#    psi = phi1 - sep_info.n0(n)/3 * theta + sep_info.xi(n)/3;
    psi_diff = phase_advance - sep_info.delta_tune(n)*theta - sep_info.xi(n)/3;
#    psi_diff
#    phase_advance
    phi_mat = phi_j{n}(:,1);
#    psi_diff_mat = psi_diff*ones(size(phi_mat));
#    psi_diff = (-1 * (psi_diff > phi_mat))*psi_diff;
#    psi = phi_j{n}(:,1) - phase_advance ...
#                        + sep_info.delta_tune(n)*theta ...
#                        + sep_info.xi(n)/3;
    psi = phi_mat - psi_diff;
#    psi
#    cos(3*psi)
    h{n} = sep_info.delta_tune(n)*k + (k.^(3/2))*sep_info.a_3n0(n).*cos(3*psi);
  end
  if (n_particles == 1)
    h = h{1};
    phi_j = phi_j{1};
  endif
  
endfunction

