## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} load_qms_asc(@var{arg})
##
## @end deftypefn

##== History
##

function retval = load_qms_asc(filepath)
  # filepath = "/Users/tkurita/WorkSpace/Synchrotron/2010.01_vaccum/qmass-data/20100126-cycle2135.asc";
  [fid, msg] = fopen(filepath, "r");
  if (fid == -1)
    error(msg);
  endif
  info = struct;
  #retval = struct("info", info);
  nline = 0;
  while (1)
    aline = fgetl(fid);
    nline++;
    if (regexp(aline, "^ScanData"))
      break;
    endif
    [S, E, TE, M, T, NM] = regexp(aline, "^DATE:\\t(\\S+)\\tTIME:\\t(\\S+)");
    if (S)
      info.scan_starting_date = T{1}{1};
      info.scan_starting_time = T{1}{2};
      continue;
    endif
    
    [S, E, TE, M, T, NM] = regexp(aline, "^First Mass:\\s+(\\S+)");
    if (S)
      info.first_mass = T{1}{1};
      continue;
    endif
    
    [S, E, TE, M, T, NM] = regexp(aline, "^Scan Width:\\s+(\\S+)");
    if (S)
      info.scan_width = T{1}{1};
      continue;
    endif
    
    [S, E, TE, M, T, NM] = regexp(aline, "^Cycle\\tCycleDate\\tCycleTime");
    if (S)
      aline = fgetl(fid);
      nline++;
      [S, E, TE, M, T, NM] = regexp(aline, "^(\\S+)\\t(\\S+)\\t(\\S+)");
      if (S)
        info.cycle = T{1}{1};
        info.cycle_date = T{1}{2};
        info.cycle_time = T{1}{3};
      endif
    endif
    
  endwhile
  fclose(fid);
  
  data = dlmread(filepath,"\t",nline,0);
  retval = tars(info, data);
  
endfunction

%!test
%! func_name(x)
