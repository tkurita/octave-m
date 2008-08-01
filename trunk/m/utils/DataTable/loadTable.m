## read tab-deliminated text data
## first line is names of data.
function result = loadTable(filePath)
  [fid, msg] = fopen(filePath, "r");
  if (fid == -1)
    error(msg);
  endif
  
  theLine = fgetl(fid);
  fclose(fid);
  if (theLine(1) == "#")
    theLine = theLine(2:end);
  endif
  result.names = csvexplode(theLine, "\t");
  result.data = load(filePath);
endfunction

