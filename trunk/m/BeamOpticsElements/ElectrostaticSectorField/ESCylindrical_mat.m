## -*- texinfo -*-
## @deftypefn {Function File} {} ESCylindrical_mat(@var{radius}, @var{beta}, @var{len})
##
## @deftypefnx {Function File} {} ESCylindrical_mat(@var{properties})
##
## Return horozontal martix of electrostatic sector field formed with cylindrical electrodes.
##
## @table @code
## @item @var{radius}
## radius [rad] of beam axis of electrostatic sector field
## @item @var{beta}
## velocity/light velocity
## @item @var{len}
## length [m] of center beam trajectory
## @end table
##
## The structre passed as an argument can have following fields.
##
## @table @code
## @item radius
## @item beta
## @item len
## @item reverse
## @end table
##
## @end deftypefn

##== History
## 2008-08-13
## * add "reverse"
## 
## ????-??-??
## * first implementation

#function a_mat = ESCylindrical_mat(a_radius, a_beta, len)
function retval = ESCylindrical_mat(varargin)
  reverse = false;
  if (isstruct(varargin{1}))
    prop = varargin{1};
    a_radius = prop.radius;
    a_beta = prop.beta;
    len = prop.len;
    if (isfield(prop, "reverse"))
      reverse = prop.reverse;
    endif
  else
    a_radius = varargin{1};
    a_beta = varargin{2};
    len = varargin{3};
  endif
  
  k = sqrt((2-a_beta^2)/a_radius^2);
  h = a_radius*a_beta^2/(1+sqrt(1-a_beta^2));
  retval = [cos(k*len), sin(k*len)/k, (1-cos(k*len))*h;
           -k*sin(k*len), cos(k*len), sin(k*len)*h;
           0, 0, 1];
  if (reverse)
    rm = [-1, 0, 0; 0,-1,0; 0,0,1];
    retval = rm * retval * rm;
  endif
endfunction 