## -*- texinfo -*-
## @deftypefn {Function File} {@var{mat} =} BMHmat(@var{radius}, @var{bmangle}, @var{edgeangle}, [@var{p_error}])
##
## horizontal matrix of bending magnet
##
## @end deftypefn

##== History
## 2007-10-26
## * add support p_error arugument

function matrix = BMHmat(radius, bmangle, edgeangle ,varargin)
  #function matrix = BMHmat(inObj)
  #  bmangle = inObj.bmangle;
  #  radius = inObj.radius;
  #  edgeangle = inObj.edgeangle;
  
  edgematrix = BME_H(radius, edgeangle, varargin{:});
  bmmatrix = [cos(bmangle), radius*sin(bmangle), radius*(1-cos(bmangle));
              -sin(bmangle)/radius, cos(bmangle), sin(bmangle);
              0, 0, 1];
  matrix = edgematrix*bmmatrix*edgematrix;
endfunction
