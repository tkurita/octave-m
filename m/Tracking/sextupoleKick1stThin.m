function result = sextupoleKick1stThin(sx, particles)
  particles = sx.premat * particles;
  x = particles(1,:);
  xprime = particles(2,:);
  y = particles(3,:);
  yprime = particles(4,:);
  ##          x      x'    x2         xx' y      y'    y2   yy'        xy        xy'    x'y
  #inputMat = [x; xprime; x.*x; x.*xprime; y; yprime; y.*y; y.*yprime; x.*y; x.*yprime; xprime.*y];
  
  ##          x      x'    x2   y      y'    y2   xy
  inputMat = [x; xprime; x.*x; y; yprime; y.*y; x.*y];
  
  result = sx.postmat * (sx.mat * inputMat);
endfunction