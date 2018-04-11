## -*- texinfo -*-
## @deftypefn {Function File} {} disp(@var{leveltabel})
## display contents of LevelTabel object
##
## @end deftypefn

function disp(lvtable)
  if ! nargin
    print_usage();
    return;
  endif
  for n = 1:length(lvtable.names)
    printf("%s : ", lvtable.names{n,1});
    printf("%f", lvtable.data(n,1));
    for m = 2:columns(lvtable.data)
      printf(", %f ", lvtable.data(n,m));
    end
    printf("\n");
  end
endfunction

%!test
%! func_name(x)
