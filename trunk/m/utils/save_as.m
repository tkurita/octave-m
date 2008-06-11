## -*- texinfo -*-
## @deftypefn {Function File} {} save_as(@var{arg})
## 
## @end deftypefn

##== History
##

function save_as(val, varname)
  eval([varname, "= val;"]);
  save("-z",[varname, ".mat"], varname);
endfunction