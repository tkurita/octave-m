## usage result = generate_particles(an_elem, particle_rec)
##
##== Parameters
## * an_elem : 出口の beta, alpha が使われる
## * particle_rec
##    .em  : a structure of emittance 
##      .x : 横方向の emittance. 単位は? [rad * m]?
##      .y : 縦方向の emittance
##    .num : 粒子の数
##    .filled
##    .pError : delP/P
##
##== Result
## [x  ;
##  x' ;
##  delP/P;
##  y  ;
##  y' ;
##  delP/P]

##== History
## 2007-10-03
## * add delP/P in result
## * derived from makeParticles

function result = generate_particles(an_elem, particle_rec)
  n = particle_rec.num;
  emx = particle_rec.em.x;
  emy = particle_rec.em.y;
  
  randPhix = rand(1,n)*2*pi;
  randPhiy = rand(1,n)*2*pi;
  beta_fun = an_elem.exitBeta;
  alpha.h = an_elem.twpar.h(2);
  alpha.v = an_elem.twpar.v(2);
  if (isfield(particle_rec, "filled") && particle_rec.filled)
    emx = rand(1,n)*emx;
    emy = rand(1,n)*emy;
  endif
  
  x = sqrt(emx.*beta_fun.h).*cos(randPhix);
  xprime = -sqrt(emx./beta_fun.h).*(alpha.h.*cos(randPhix) + sin(randPhix));
  
  y = sqrt(emy.*beta_fun.v).*cos(randPhiy);
  yprime = -sqrt(emy./beta_fun.v).*(alpha.v.*cos(randPhiy) + sin(randPhiy) );
  p_error = 0;
  if (isfield(particle_rec, "pError"))
    p_error = particle_rec.pError;
  endif
  p_error_vec = repmat(p_error,1,n);
  result = [x; xprime; p_error_vec; y; yprime ;p_error_vec];
endfunction
