##== History
## 2007-10-03
## * should be obsoluted
## * use kicker_kick

function result = steererKick(steerer, particles)
  particles = steerer.halfDuct * particles;
  result = steerer.halfDuct * (particles + repmat(steerer.kickVector, 1, size(particles)(2)));
endfunction
