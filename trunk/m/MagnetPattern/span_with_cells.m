## usage : result = span_with_cells(cells)
##  build a part of magnet pattern of table form data
##  the result is a retuned value from span_struct function

function result = span_with_cells(cells)
  fname = cells{1,3};
  tlist = cell2mat(cells(:,1));
  blist = cell2mat(cells(:,2));
  result = span_struct(tlist,blist,fname);
endfunction
  