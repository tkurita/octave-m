## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} save_data(@var{hamnics_ctrl}, @var{data_name}, @var{file})
## description
## @strong{Inputs}
## @table @var
## @item arg1
## description of @var{arg}
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## description of @var{retval}
## @end table
##
## @end deftypefn

function retval = save_data(x, data_name, file)
  if nargin < 2
    print_usage();
    return;
  endif

  switch nargin
    case 2
      fid = stdout;
    otherwise
      fid = fopen(file, "w");
  endswitch
  fprintf(fid, "%g\n", subsref(x, struct("type", {"."}, "subs", {data_name})));
  if fid > 2
    fclose(fid);
  endif
endfunction
