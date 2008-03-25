## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} flat_cell(@var{c})
##
## flatten nested cell array 
##
## @end deftypefn

##== History
## 2008-03-25
## initial implementaion

function result = flat_cell(c)
  result = {};
  for n = 1:length(c)
    if (iscell(c{n}))
      sub_cell = flat_cell(c{n});
      for m = 1:length(sub_cell)
        result{end+1} = sub_cell{m};
      end
      
    else
      result{end+1} = c{n};
    end
  end
  
endfunction