## -*- texinfo -*-
## @deftypefn {Function File} {@var{mat} =} BMHmat(@var{prpperty_struct})
## @deftypefn {Function File} {@var{mat} =} BMHmat(@var{radius}, @var{bmangle}, @var{edgeangle}, [@var{p_error}])
##
## horizontal matrix of bending magnet
##
## @end deftypefn

##== History
## 2008-06-02
## * return edgek
##
## 2007-11-23
## * accept one argument of structure.
##
## 2007-10-26
## * add support p_error arugument

#function matrix = BMHmat(radius, bmangle, edgeangle ,varargin)
function [matrix, edgek] = BMHmat(varargin)
  if (isstruct(varargin{1}))
    prop = varargin{1};
    radius = prop.radius;
    bmangle = prop.bmangle;
  else
    radius = varargin{1};
    bmangle = varargin{2};
    edgeangle = varargin{3};
    if (length(varargin) > 3)
      pError = varargin{4};
    else
      pError = 0;
    endif
    prop = tars(radius, edgeangle, pError);
  endif
    
  #edgematrix = BME_H(radius, edgeangle, varargin{:});
  edgematrix = BME_H(prop);
  bmmatrix = [cos(bmangle), radius*sin(bmangle), radius*(1-cos(bmangle));
              -sin(bmangle)/radius, cos(bmangle), sin(bmangle);
              0, 0, 1];
  matrix = edgematrix*bmmatrix*edgematrix;
  edgek = -1*edgematrix(2,1);
endfunction
