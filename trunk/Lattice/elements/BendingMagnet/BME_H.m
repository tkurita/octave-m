## -*- texinfo -*-
## @deftypefn {Function File} {@var{mat} =} BME_H(@var{radius} @var{edgeangle} [,@var{p_error}])
##
## horizontal edge matrix of bending magnet
##
## @end deftypefn

##== History
## 2007-10-26
## * add argument p_error

function matrix = BME_H(radius,edgeangle ,varargin)
  p_error = 0;
  if (length(varargin) > 0)
    p_error = varargin{1};
  endif
    
  matrix = [1, 0, 0;
            (tan(edgeangle)/radius)/(1+p_error), 1, 0;
            0, 0, 1];
  #matrix = eye(3);
endfunction
