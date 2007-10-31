## Usage : result = sx_thin_kick(sx_rec, particles)
##

##== History
## 2007-10-03
## * renamed from sextupoleKickThin

function result = sx_thin_kick(sx_rec, particles)
  particles = sx_rec.premat * particles;
  x = particles(1,:);
  xprime = particles(2,:);
  y = particles(4,:);
  yprime = particles(5,:);
  
  xprime = xprime - sx_rec.llamda*(x.^2 - y.^2);
  yprime = yprime + 2*sx_rec.llamda.*x.*y;
  result = sx_rec.postmat * [x; xprime; particles(3,:); y; yprime; particles(6,:)];
endfunction