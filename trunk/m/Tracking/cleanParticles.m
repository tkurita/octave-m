function outparticles = cleanParticles(inparticles)
  #size(inparticles)
  particles = inparticles(:,!isnan(inparticles(1,:))); #NaN の除去  
  outparticles = particles(:,abs(particles(1,:)) < 0.5); #大きな振幅の粒子を除去
  if (!length(outparticles))
    error("No valid particles.\n");
  endif
endfunction
