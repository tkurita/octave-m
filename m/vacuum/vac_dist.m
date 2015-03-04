## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} vac_dist(@var{arg})
##
## @end deftypefn

##== History
##

function retval = vac_dist(measured_data, varargin)
   opts = get_properties(varargin,...
                            {"origin"},...
                            {0});
   velems = vac_elements(opts.origin);
   retval = [];
   for n = 1:rows(measured_data)
     elem_name = measured_data{n,1};
     val = measured_data{n,2};
     if (!isnan(val))
       for m = 1:rows(velems)
         if strcmp(velems{m, 1}, elem_name)
           retval(end+1, :) = [velems{m,2}, val];
         endif
       endfor
     endif
   endfor
endfunction

%!test
%! func_name(x)
