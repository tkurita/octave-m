## -- retval = load_NA_csv(filepath)
##    load csv file of KEYSIGHT FieldFox
##
##  * Inputs *
##    arg1 : 
##
##  * Outputs *
##    [Hz, dB] or [Hz, degree]
##    
##  * Exmaple *
##
##  See also: 

function data = load_NA_csv(filepath)
  fid = open_zip_file(filepath);
  while(1)
    l = fgetl(fid);
    spos = strfind(l, "BEGIN");
    if (length(spos) && (spos(1) == 1))
      break;
    endif
  endwhile
  
  data = csvread(fid);
  fclose(fid);
  data(end,:) = [];
endfunction


%!test
%! func_name(x)
