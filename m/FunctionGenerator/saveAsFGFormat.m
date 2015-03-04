## 任意関数発生器で読み込まれる CVS形式でdataを保存
## usage: saveAsFGFormat(filename,data)
function saveAsFGFormat(filename,data,comment)
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

  for i=2:4
	fprintf(outFID,"\r\n");
  endfor

  for i=1:breakNum
	fprintf(outFID,"%i,%i,%i,%i\r\n",data(i),data(breakNum+i),data(2*breakNum+i),data(3*breakNum+i));
  endfor

  fclose(outFID);
endfunction