function codList = concatCOD(codList1, codList2, shiftValue)
  codList2 = codList2 + repmat([shiftValue, 0], size(codList2)(1), 1);
  codList = [codList1; codList2];
endfunction
