## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} table_with_bpattern(@var{bpattern}, @var{file})
## @seealso{build_pattern, csv_with_bpattern}
##
## @end deftypefn

##== History
## 2008-12-04
## * First implementation

function table_with_bpattern(@var{bpattern}, @var{file})
  t = bpattern{1}.tPoints(:);
  b = bpattern{1}.bPoints(:);
  for n = 2:length(bpattern)
    t =[t; bpattern{n}.tPoints(:)];
    b =[b; bpattern{n}.bPoints(:)];
  endfor
  tb = [t, b];
  
  is_open_file = false;
  if (ischar(file))
    [fid , msg] = fopen(file, "w");
    if (fid < 0)
      error(msg);
    endif
    is_open_file = true;
  elseif (isfid(file))
    fid = file;
  else
    error("File specification is invalid.");
  endif
  
  template = ftemplate_for_mat(tb(1,:));
  for n = 1:rows(tb);
    fprintf(fid, template, tb(n, :));
  endfor
  if (is_open_file)
    fclose(fid);
  endif
endfunction

%!test
%! table_with_bpattern(x)
