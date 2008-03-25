## -*- texinfo -*-
## @deftypefn {Function File} {} clean_particles(@var{inparticles})
##
## Return a matrix removing rows which have NaN or large values at (1,:) from @var{inparticeles}
##
## Every rows of @{invarticles} indicate points of each particles in the phase sepace.
##
##
## @end deftypefn

##== History
## 2008-01-16
## * derived from cleanParticles

function outparticles = clean_particles(inparticles)
  #size(inparticles)
  amp_limit = 0.5; #[m]
  particles = inparticles(:,!isnan(inparticles(1,:))); #NaN の除去  
  outparticles = particles(:,abs(particles(1,:)) < amp_limit); #大きな振幅の粒子を除去
  if (!length(outparticles))
    error("No valid particles.\n");
  endif
endfunction
