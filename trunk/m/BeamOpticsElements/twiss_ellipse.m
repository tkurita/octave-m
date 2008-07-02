## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} twiss_ellipse(@var{elem}, @var{pos}, @var{horv}, @var{em})
##
## @table @code
## @item @var{em}
## emittance i.e. the area of the ellipse. [pi*m*rad].
## 
## @end table
## 
## @end deftypefn

##== History
## 2008-06-18
## * first implementation

function retval = twiss_ellipse(elem, pos, horv, em)
  twpar = twiss_parameters_at(elem, pos).(horv);
  b = twpar(1);
  a = (2);
  phi = linspace(0, 2*pi, 100);
  x = sqrt(em.*b).*cos(phi);
  xprime = -sqrt(em./b).*(a.*cos(phi) + sin(phi));
  retval = [x(:), xprime(:)];
endfunction