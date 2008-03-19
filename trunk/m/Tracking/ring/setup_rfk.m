## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} func_name(@var{arg})
##
## @end deftypefn

##== History
## 2008-03-17
## * first implementaion

function an_elem = setup_rfk(rfk_rec, an_elem, brho, particle_rec)
  k = mev_with_brho(brho, particle_rec.charge, particle_rec.mass);
  m0c2 = mass_energy(particle_rec.mass);
  theta = atan((rfk_rec.l/rfk_rec.d)...
            *(particle_rec.charge*rfk_rec.V*1e-6*(k + m0c2))...
            /(k*(k + 2*m0c2)));
  an_elem.kick_angle = theta(:)';
  an_elem.apply = @through_rfk;
  an_elem.n_particle = particle_rec.num;
  an_elem.track_info = "special";
  a_mat = an_elem.mat_half;
  an_elem.premat = [a_mat.h, zeros(3); zeros(3), a_mat.v];  
  an_elem.postmat = an_elem.premat;
endfunction