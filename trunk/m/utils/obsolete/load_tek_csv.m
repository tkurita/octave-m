## -*- texinfo -*-
## @deftypefn {Function File} {} load_tek_csv(@var{fname})
##
## read csv data of TEKTRONICS's oscilloscope
##
## The result is a structure which has following fields.
##
## @table @code
## @item data
## cell array of matrixes
## @item samplerate
## sampling rate [Hz]
## @end table
##
## @end deftypefn

##== History
## 2008-07-02
## * add samplerate to output
## 
## 2007-04-12
## * initial

function retval = load_tek_csv(file_path)
  warning("load_tek_csv is deprecated. Use load_osc_csv");
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

  retval.data = {};
  for n = 2:ndata;
    retval.data{end+1} = [data(:,1), data(:,n)];
  endfor

  retval.samplerate = 1/(data(2,1) - data(1,1));
endfunction