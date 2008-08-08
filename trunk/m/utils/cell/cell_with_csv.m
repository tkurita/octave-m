## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} func_name(@var{arg})
##
## @end deftypefn

##== History
##

function retval = cell_with_csv(file)
  retval = {};
  [fid, msg] = fopen(file, "r");
  if (fid == -1)
    error(msg);
  endif
  aline = fgetl(fid);
  while(aline != -1)
    retval{end+1} = csvexplode(aline);
    aline = fgetl(fid);
  endwhile
  fclose(fid);
endfunction