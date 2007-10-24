## -- usage : matrix = BMHmat(radius,bmangle,edgeangle)
##
## horizontal matrix of bending magnet

function matrix = BMHmat(radius,bmangle,edgeangle)
  #function matrix = BMHmat(inObj)
  #  bmangle = inObj.bmangle;
  #  radius = inObj.radius;
  #  edgeangle = inObj.edgeangle;
  
  edgematrix = BME_H(radius, edgeangle);
  bmmatrix = [cos(bmangle), radius*sin(bmangle), radius*(1-cos(bmangle));
  -sin(bmangle)/radius, cos(bmangle), sin(bmangle);
  0, 0, 1];
  matrix = edgematrix*bmmatrix*edgematrix;
endfunction
