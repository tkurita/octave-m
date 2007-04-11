## -- usage : matrix = BME_V2(radius, edgeangle, b)
##
## vertical edge matrix of bending magnet
## 磁極端部でビーム進行方向に徐々に磁場が弱くなる効果を考慮

function matrix = BME_V2(radius,edgeangle, b)
  matrix = [1, 0, 0;
  -tan(edgeangle)/radius + b/cos(edgeangle)/6/(radius^2), 1, 0;
  0, 0, 1];
endfunction
