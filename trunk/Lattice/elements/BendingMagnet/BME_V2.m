## -- usage : matrix = BME_V2(radius, edgeangle, b)
##
## vertical edge matrix of bending magnet
## ���ɒ[���Ńr�[���i�s�����ɏ��X�Ɏ��ꂪ�キ�Ȃ���ʂ��l��

function matrix = BME_V2(radius,edgeangle, b)
  matrix = [1, 0, 0;
  -tan(edgeangle)/radius + b/cos(edgeangle)/6/(radius^2), 1, 0;
  0, 0, 1];
endfunction
