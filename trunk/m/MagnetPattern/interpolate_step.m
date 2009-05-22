## -*- texinfo -*-
## @deftypefn {Function File} {} interpolate_step([@var{tmin}, @var{bmin})], [@var{tmax}, @var{bmax}])
##
## Interpolate smooth step pattern.
##
## @end deftypefn

##== History
## 2009-05-22
## * renamed from stepInterpolate

function result = interpolate_step(p1, p2)
  tmin = p1(1);
  tmax = p2(1);
  bmin = p1(2);
  bmax = p2(2);
  tr1=0.25;
  tr2=0.75;
  br1 = (tr1.^3)./3.*16;
  br2 = 1 - 2*(3/4 - tr2) - (16/3)*((tr2 -1/2).^3);
  #2.*(tr2-1/2).*((tr2 - 1/2).^2 -3/4)+1/2;
  t1 = tmin + (tmax-tmin).*tr1;
  t2 = tmin + (tmax-tmin).*tr2;
  b1 = bmin + (bmax-bmin).*br1;
  b2 = bmin + (bmax-bmin).*br2;
  result = [p1;t1,b1;t2,b2;p2];
endfunction

#function result = standardThirdSplieStep(x)
#  #result = 2.*(x-1/2).*((x - 1/2).^2 -3/4)+1/2;
#  result = (x.^3)./3.*16;
#endfunction

#standardThirdSplieStep(0.75)
#
#stepInterpolate([649.2, 0.5635], [699.2, 0.5426])
#
#standardThirdSplieStep(0.25)
#
#675.4	0
#687.9	2.8
#712.9	29
#725.4	31.8
#
#stepInterpolate([675.4, 0], [725.4, 31.8])
#
#649.2	0.5635
#661.7	0.5618
#686.7	0.5443
#699.2	0.5426
#
#stepInterpolate([649.2, 0.5635], [699.2, 0.5426])