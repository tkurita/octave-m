## Usage : out_particles = through_mat(mat_rec, in_particles)
##    out_particles = mat_rec.mat * in_particles;

##== History
## 2007-10-03
## * initial implementaion

function out_particles = through_mat(mat_rec, in_particles)
  out_particles = mat_rec.mat * in_particles;
endfunction

#function particles = through_mat(mat_rec, particles)
#  particles = mat_rec.mat * particles;
#endfunction
