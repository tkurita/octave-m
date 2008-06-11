## Calculate x and p from action angle variables


function x_p = x_p_with_action_angle(phi, j, tw_beta, tw_alpha)
  x = sqrt(2*tw_beta.*j).*cos(phi);
  p = - sqrt(2.*j./tw_beta).*( sin(phi) + tw_alpha.*cos(phi) );
  x_p = [x(:), p(:)];
endfunction