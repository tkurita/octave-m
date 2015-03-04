## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} sx_thin_kick_nocross(@var{sx_rec}, @var{particles})
##
## @end deftypefn

##== History
## 2007-10-16
## * derived from sx_thin_kick
## * deprecated. y emittance = 0 cause same effects
##
## 2007-10-03
## * renamed from sextupoleKickThin

function result = sx_thin_kick_nocross(sx_rec, particles)
  particles = sx_rec.premat * particles;
  x = particles(1,:);
  xprime = particles(2,:);
  y = particles(4,:);
  yprime = particles(5,:);
  
  #xprime = xprime - sx_rec.llamda*(x.^2 - y.^2);
  xprime = xprime - sx_rec.llamda*(x.^2);
  yprime = yprime + 2*sx_rec.llamda.*x.*y;
  result = sx_rec.postmat * [x; xprime; particles(3,:); y; yprime; particles(6,:)];
endfunction