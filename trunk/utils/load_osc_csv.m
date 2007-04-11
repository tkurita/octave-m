## usage : outRec = load_osc_csv(file_path)
##      横河のオシロスコーブのデータを読み込む
## 
## = result
## outRec
##  .data -- cell array of matrix

## = History
##
## 2006-??-??
## * first implementaion

function outRec = load_osc_csv(file_path)
  [fid, msg] = fopen(file_path, "r");
  if (fid == -1)
    error(msg);
  endif
  
  ## read header
  nhead = 1;
  aline = deblank(fgetl(fid));
  while (aline != -1)
    nhead++;
    if (length(aline) == 1)
      break;
    endif
    cells = csvexplode(aline);
    for n = 1:length(cells) # remove heading spaces
      astr = cells{n};
      if (ischar(astr))
        amatch = regexp("[^ .]+", astr);
        cells{n} = astr(amatch(1):amatch(2));
      endif
      
    endfor
    outRec.(cells{1}) = cells(2:end);
    aline = deblank(fgetl(fid));
  endwhile
  fclose(fid);
  
  data = csvread(file_path, nhead, 0);
  block_size = outRec.BlockSize{1};
  sample_rate = outRec.SampleRate{1};
  switch (outRec.SampleRate{2})
    case ("MHz")
      sample_rate = sample_rate*1e6;
    case ("kHz")
      sample_rate = sample_rate*1e3;
  endswitch
  trigger_point = outRec.TriggerPointNo{1};
  time = (-1*(trigger_point-1)):(block_size - trigger_point);
  msec = time/sample_rate*1e3;
  outRec.data = {[msec(:), data(:,1)], [msec(:), data(:,2)]};
endfunction