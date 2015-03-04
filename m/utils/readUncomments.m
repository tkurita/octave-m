function result = readUncomments(filePath)
  [fid, msg] = fopen(filePath, "r");
  if (fid == -1)
    error(msg);
  endif
  result = "";
  while (isstr(s = fgetl(fid)))
    match = regexp("^( |\t)*#", s);
    if (length(match) == 0);
      result = [result; s];
    endif
    
  endwhile
  fclose(fid);
endfunction
