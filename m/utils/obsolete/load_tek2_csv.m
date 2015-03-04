## -*- texinfo -*-
## @deftypefn {Function File} {} load_tekall_csv(@var{fname})
##
## read csv data of newer TEKTRONICS's oscilloscope
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
## 2009-04-12
## * initial

function retval = load_tek2_csv(file_path)
  warning("load_tek2_csv is deprecated. Use load_osc_csv");
  #file_path = "tek0002ALL.csv";
  [fid, msg] = fopen(file_path, "r");
  if (fid == -1)
    error(msg);
  endif
  
  ## skip 3 lines
  for (n = 1:3)
    fgetl(fid);
  endfor
  
  ## read header
  nhead = 2;
  aline = deblank(fgetl(fid));
  ndata = 2;
  while (aline != -1)
    nhead++;
    if (length(aline) == 1)
      #break;
    endif
    cells = csvexplode(aline);
    
    if (!ischar(cells{1}))
      ndata = length(cells);
      break;
    endif
    if strcmp(cells{1}, "Label")
      aline = fgetl(fid);
      cells = csvexplode(aline);
      retval.("Label") = cells;
      nhead++;
    else
      alabel = strrep(cells{1}, " ", "_");
      retval.(alabel) = cells{2};
    endif
    aline = deblank(fgetl(fid));
  endwhile
  fclose(fid);
  
  data = csvread(file_path, nhead, 0);
  data = data(1:end-1,:);
  retval.data = {};
  retval.samplerate = 1/(data(2,1) - data(1,1));
  t = data(:,1);
  switch (retval.Horizontal_Units)
    case ("S")
      t = t*1e3;
  endswitch
  
  for n = 2:ndata;
    retval.data{end+1} = [t, data(:,n)];
  endfor

endfunction