## usage result = makeParticles(theElement, emx, emy, n)
##
##= Parameters
## * theElement -- 出口の beta, alpha が使われる
## * emx -- 横方向の emittance
## * emy -- 縦方向の emittance
## * n -- 粒子の数
##
##= Result
## [x  ;
##  x' ;
##  y  ;
##  y' ]

function result = makeParticles(theElement, particleRecord)
  n = particleRecord.num;
  emx = particleRecord.em.x;
  emy = particleRecord.em.y;
  
  randPhix = rand(1,n)*2*pi;
  randPhiy = rand(1,n)*2*pi;
  beta = theElement.exitBeta;
  alpha.h = theElement.twpar.h(2);
  alpha.v = theElement.twpar.v(2);
  if (isfield(particleRecord, "filled") & particleRecord.filled)
    emx = rand(1,n)*emx;
    emy = rand(1,n)*emy;
  endif
  x = sqrt(emx.*beta.h).*cos(randPhix);
  xprime = -sqrt(emx./beta.h).*(alpha.h.*cos(randPhix) + sin(randPhix));
  
  y = sqrt(emy.*beta.v).*cos(randPhiy);
  yprime = -sqrt(emy./beta.v).*(alpha.v.*cos(randPhiy) + sin(randPhiy) );
  
  result = [x; xprime; y; yprime];
endfunction
