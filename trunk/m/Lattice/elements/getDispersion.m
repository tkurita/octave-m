function eater = getDispersion(fullMatrix, cosmu)
  #initial dispersion function
  eater = (1/(2*(1-cosmu))) * [fullMatrix(1,3)+fullMatrix(1,2)*fullMatrix(2,3)-fullMatrix(2,2)*fullMatrix(1,3);
  fullMatrix(2,3)+fullMatrix(2,1)*fullMatrix(1,3)-fullMatrix(1,1)*fullMatrix(2,3)];
  eater = [eater;1];
endfunction