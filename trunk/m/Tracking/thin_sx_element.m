## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} func_name(@var{arg})
##
## @end deftypefn

##== History
##

function result = thin_sx_element(sx, name)
  result = struct("name", name, "strength", sx, "llamda", sx/2 ...
                , "track_info", "special");
  result.apply = @sx_thin_kick;
endfunction