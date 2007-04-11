## -- usage : matrix = BME_H(radius,edgeangle)
##
## horizontal edge matrix of bending magnet

function matrix = BME_H(radius,edgeangle)
	matrix = [1, 0, 0;
			  tan(edgeangle)/radius, 1, 0;
			  0, 0, 1];
	#matrix = eye(3);
endfunction
