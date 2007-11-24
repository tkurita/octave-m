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
## @end deftypefn

#function a_mat = ESCylindrical_mat(a_radius, a_beta, len)
function a_mat = ESCylindrical_mat(varargin)
  if (isstruct(varargin{1}))
    prop = varargin{1};
    a_radius = prop.radius;
    a_beta = prop.beta;
    len = prop.len;
  else
    a_radius = varargin{1};
    a_beta = varargin{2};
    len = varargin{3};
  endif
  
  k = sqrt((2-a_beta^2)/a_radius^2);
  h = a_radius*a_beta^2/(1+sqrt(1-a_beta^2));
  a_mat = [cos(k*len), sin(k*len)/k, (1-cos(k*len))*h;
           -k*sin(k*len), cos(k*len), sin(k*len)*h;
           0, 0, 1];
endfunction 