## -*- texinfo -*-
## @deftypefn {Function File} {@var{mat} =} BME_H(@var{property_struct})
## @deftypefnx {Function File} {@var{mat} =} BME_H(@var{radius} @var{edgeangle} [,@var{p_error}])
##
## horizontal edge matrix of bending magnet
##
## @end deftypefn

##== History
## 2007-11-23
## * accept one argument of structure.
##
## 2007-10-26
## * add argument p_error

#function matrix = BME_H(radius,edgeangle ,varargin)
function matrix = BME_H(varargin)
  p_error = 0;
  if (isstruct(varargin{1})
    prop = varargin{1};
    radius = prop.radius;
    edgeangle = prop.edgeangle;
    if (isfield(prop, "pError"))
      p_error = prop.pError;
    endif
  else
    radius = varargin{1};
    edgeangle = varargin{2};
    if (length(varargin) > 2)
      p_error = varargin{3};
    endif
  endif
  
  matrix = [1, 0, 0;
            (tan(edgeangle)/radius)/(1+p_error), 1, 0;
            0, 0, 1];
  #matrix = eye(3);
endfunction
