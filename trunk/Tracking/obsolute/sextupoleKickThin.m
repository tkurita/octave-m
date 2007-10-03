##== History
## 2007.10.03
## * obsolute

function result = sextupoleKickThin(sx, particles)
  warning("oboslute. use sx_thin_kick.");
  #printf("sextupoleKickThin\n");
  particles = sx.premat * particles;
  x = particles(1,:);
  xprime = particles(2,:);
  y = particles(3,:);
  yprime = particles(4,:);

  xprime = xprime - sx.llamda*(x.^2 - y.^2);
  yprime = yprime + 2*sx.llamda.*x.*y;
  
  result = sx.postmat * [x; xprime; y; yprime];
endfunction