## 三光社任意関数発生器で読み込まれる CVS形式でdataを保存
## usage: save_fgcsv(filename,data)
function save_fgcsv(filename, data, comment)
  maxPoints = 131072;
  breakNum = 32768;
  if (length(data) < maxPoints)
	data(length(data)+1:maxPoints) = 0;
	##error("Given data does not has enough data length. The length must be %i\n",maxPoints)
  elseif (length(data) > maxPoints)
	error("Given data is too long. The length must be less than %i\n",maxPoints)
  endif

  [outFID,msg] = fopen(filename,"w")
  
  fprintf(outFID,"%s\r\n",comment);

  for n = 2:4
	fprintf(outFID,"\r\n");
  endfor

  for n = 1:breakNum
	fprintf(outFID,"%i,%i,%i,%i\r\n",data(n), data(breakNum+n), data(2*breakNum+n), data(3*breakNum+n));
  endfor

  fclose(outFID);
endfunction