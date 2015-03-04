## usage : [tPoints,bPoints] = definedPoints(patternSet)
##    or   pointsSet = definedPoints(patternSet)
##
## extract data points defined in patternSet
##

function varargout = definedPoints(patternSet)
	tList = [];
	bList = [];

	for i = 1: length(patternSet)
		tPoints = patternSet{i}.tPoints;
		bPoints = patternSet{i}.bPoints;
		tList = [tList,tPoints];
		bList = [bList,bPoints];
	endfor
  
	switch nargout
		case (0)
			varargout = {[tList;bList]'};
		case (1)
			varargout = {[tList;bList]'};
		  #case (2)
		otherwise
			varargout = {tList,bList};
		endswitch
endfunction