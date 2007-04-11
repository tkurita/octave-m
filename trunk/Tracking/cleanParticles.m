function outparticles = cleanParticles(inparticles)
  #size(inparticles)
  particles = inparticles(:,!isnan(inparticles(1,:))); #NaN ‚Ìœ‹  
  outparticles = particles(:,abs(particles(1,:)) < 1); #‘å‚«‚ÈU•‚Ì—±q‚ğœ‹
  size(outparticles)
  if (!length(outparticles))
    error("No valid particles.\n");
  endif
endfunction
