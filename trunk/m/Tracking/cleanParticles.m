function outparticles = cleanParticles(inparticles)
  #size(inparticles)
  particles = inparticles(:,!isnan(inparticles(1,:))); #NaN �̏���  
  outparticles = particles(:,abs(particles(1,:)) < 0.5); #�傫�ȐU���̗��q������
  if (!length(outparticles))
    error("No valid particles.\n");
  endif
endfunction
