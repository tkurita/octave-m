## Usage : result = deltaY(xy1, xy2)
##      result = [xy1(:,1), xy1(:,2)-xy2(:,2)];

function result = deltaY(xy1, xy2)
  result = [xy1(:,1), xy1(:,2)-xy2(:,2)];
endfunction
