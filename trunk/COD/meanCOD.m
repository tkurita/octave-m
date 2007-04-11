function result = meanCOD(codAtBPM)
  ## COD をCODの平均値からの差分にする。
  nField = 0;
  sumCOD = 0;

  for [val, key] = codAtBPM
	nField++;
	sumCOD += val;
  endfor

  meanVal = sumCOD/nField;
  
  for [val, key] = codAtBPM
	codAtBPM.(key) = val - meanVal;
  endfor

  result = codAtBPM;
endfunction