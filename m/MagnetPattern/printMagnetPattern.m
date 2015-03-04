function printMagnetPattern(patternSet)
  printf("[msec]\tmagnet\tfunction\n");
  for i = 1: length(patternSet)
	tPoints = patternSet{i}.tPoints;
	bPoints = patternSet{i}.bPoints;
	printf("%5.1f\t%7.4f\t%s\n",tPoints(1),bPoints(1),patternSet{i}.funcType);
	for j = 2:length(tPoints)
	  printf("%5.1f\t%7.4f\n",tPoints(j),bPoints(j));
	endfor
  endfor
endfunction