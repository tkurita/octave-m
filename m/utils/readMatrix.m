## usage : result = readMatrix(filePath [,SEP]);
##
## extract matrix from file "filePath"
## the lines begin with "#" are ignored.
## matrix data is separeated text with SEP.
## default value of SEP is ","

function result = readMatrix(filePath, varargin)
  [fid, msg] = fopen(filePath, "r");
  if (fid == -1)
    error(msg);
  endif
  cellmat = {};
  while (isstr(s = fgetl(fid)))
    match = regexp("^( |\t)*#", s);
    if (length(match) == 0);
      arglist = {s,varargin{:}};
      cells = csvexplode(arglist{:});
      #result = [result; s];
      cellmat(end+1,:) = cells; 
    endif
    
  endwhile
  fclose(fid);
  result = cell2mat(cellmat);
endfunction
