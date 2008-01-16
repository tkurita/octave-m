##== History
## 2008-01-16
## * obsolete. use clean_particles.m

function outparticles = cleanParticles(inparticles)
  #size(inparticles)
  warning("cleanParticles is obsolete. Use clean_particles");
  particles = inparticles(:,!isnan(inparticles(1,:))); #NaN の除去  
  outparticles = particles(:,abs(particles(1,:)) < 0.5); #大きな振幅の粒子を除去
  if (!length(outparticles))
    error("No valid particles.\n");
  endif
endfunction
