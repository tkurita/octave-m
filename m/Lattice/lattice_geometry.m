## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} lattice_geometry()
## obtain lattice record which only have geometory infomation
##
## @strong{Outputs}
## @table @var
## @item retval
## description of @var{retval}
## @end table
##
## @end deftypefn

##== History
##

function retval = lattice_geometry()
   all_elements = lattice_definition()(NA, NA);
   pos = 0;
   for n = 1:length(all_elements)
     elem = all_elements{n};
     elem.entrancePosition = pos;
     elem.centerPosition = pos + elem.len;
     pos = pos + elem.len;
     elem.exitPosition = pos;
     all_elements{n} = elem;
   endfor
   retval.lattice = all_elements;
endfunction

%!test
%! func_name(x)
