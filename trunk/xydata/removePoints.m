## Usage : xydata = removePoints(xydata, data_indexes)
##
## = Examples
##  xydata = removePoints([1,2;3,4], [1])

function xydata = removePoints(xydata, data_indexes)
  for n = 1:length(data_indexes)
    target_index = data_indexes(n);
    xydata(target_index, :) = [];
  endfor
endfunction
