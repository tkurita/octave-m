## -*- texinfo -*-
## @deftypefn {Function File} {} save_as(@var{value}, @var{variable_name})
## 
## Save the value @var{value} as @var{variable_name} into the file "@var{variable_name}.mat"
## @end deftypefn

##== History
##

function save_as(val, varname)
  eval([varname, "= val;"]);
  save("-z",[varname, ".mat"], varname);
endfunction