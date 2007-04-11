function result = steererKick(steerer, particles)
  particles = steerer.halfDuct * particles;
  result = steerer.halfDuct * (particles + repmat(steerer.kickVector, 1, size(particles)(2)));
endfunction
