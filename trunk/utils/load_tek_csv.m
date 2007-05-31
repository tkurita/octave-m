## usage : outRec = load_tek_csv(file_path)
##      read csv data of TEKTRONICS's oscilloscope
## 
## = result
## outRec
##  .data -- cell array of matrix

## = History
## 2007-04-12
## * initial

function outRec = load_tek_csv(file_path)
  #file_path = "TEK00000.CSV"
  [fid, msg] = fopen(file_path, "r");
  if (fid == -1)
    error(msg);
  endif
  
  ## read header
  nhead = 1;
  aline = deblank(fgetl(fid));
  ndata = 2;
  while (aline != -1)
    nhead++;
    if (length(aline) == 1)
      break;
    endif
    cells = csvexplode(aline);
    
    if (!ischar(cells{1}))
      ndata = length(cells);
      break;
    endif
      
    aline = deblank(fgetl(fid));
  endwhile
  fclose(fid);
  
  data = csvread(file_path, nhead, 0);

  outRec.data = {};
  for n = 2:ndata;
    outRec.data{end+1} = [data(:,1), data(:,n)];
  endfor
  
endfunction