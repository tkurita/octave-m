## -*- texinfo -*-
## @deftypefn {Function File} {@var{particles} =} generate_particles(@var{particle_rec}, @var{element_rec} [,@var{position}])
##
## Generate a matrix of particles given by the emmintance, momentum error and the number of particles which is specified with @var{particle_rec}.
## 
## The result of matrix is
## [x(n)  ;
##  x'(n) ;
##  delP/P(n);
##  y(n)  ;
##  y'(n) ;
##  delP/P(n)]
##
## @var{particle_rec} can have following fields.
##
## @table @code
## @item em.x
## Horizontal emittance [rad *m]
##
## @item em.y
## Vertical emittance [rad * m]
##
## @item num
## Number of particles.
## 
## @item filled
## @item pError
## momentum error. delta P/P
## @end table
## 
## The eclipse of the generated particles are determined by the twiss parameters at @var{position} of @var{element_rec}. @var{position} should be "entrance", "center" or "exit". If @var{position} is omitted, "exit" is a default value.
## 
##
## @end deftypefn

##== History
## 2007-10-03
## * add delP/P in result
## * derived from makeParticles

#function result = generate_particles(an_elem, particle_rec)
function result = generate_particles(varargin)
  particle_rec = varargin{1};
  an_elem = varargin{2};
  if (length(varargin) > 2)
    pos_in_elem = varargin{3};
  else
    pos_in_elem = "exit";
  endif
  
  n = particle_rec.num;
  emx = particle_rec.em.x;
  emy = particle_rec.em.y;
  
  randPhix = rand(1,n)*2*pi;
  randPhiy = rand(1,n)*2*pi;
  twpar = an_elem.([pos_in_elem, "Twpar"]);
  beta_fun.h = twpar.h(1);
  beta_fun.v = twpar.v(1);
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
