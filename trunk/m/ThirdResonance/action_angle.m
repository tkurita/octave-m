## -*- texinfo -*-
## @deftypefn {Function File} {} action_angle(@var{xy}, @var{tw_beta}, @var{tw_alpha})
##
## Calculate action anble variables
##
## @end deftypefn

function phi_j = action_angle(particles, tw_beta, tw_alpha)
  x = particles(:,1);
  xprime = particles(:,2);
  j = (1/(2*tw_beta)).*(x.^2 + (tw_beta.*xprime + tw_alpha.*x).^2);
  cos_phi = x./sqrt(2.*j.*tw_beta);
  phi = acos(cos_phi);
  sin_phi = - (tw_alpha.*cos_phi + sqrt(tw_beta./(2*j)).*xprime );
  shift_mat = sin_phi < 0;
  phi = 2*pi*shift_mat+((ones(size(phi))-2*shift_mat).*phi);
  phi_j = [phi, j];
endfunction