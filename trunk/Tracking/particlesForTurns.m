function targetParticles = particlesForTurns(particles, nParticle, turnRange, varargin)
  if (length(varargin) == 0)
    horv = "h";
  else
    horv = varargin{1};
  endif
  
  switch horv
    case "h"
      targetParticles = particles(1:2, nParticle*(turnRange(1)-1) + 1:nParticle*turnRange(end));
    case "v"
      targetParticles = particles(3:4, nParticle*(turnRange(1)-1) + 1:nParticle*turnRange(end));
  endswitch
  targetParticles = cleanParticles(targetParticles)'.*1e3;
endfunction