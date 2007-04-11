## -- usage : matrix = BME_V(radius,edgeangle)
##
## vertical edge matrix of bending magnet

function matrix = BME_V(radius,edgeangle)
  matrix = [1, 0, 0;
  -tan(edgeangle)/radius, 1, 0;
  0, 0, 1];
endfunction
