## -*- texinfo -*-
## @deftypefn {Function File} {} load_osc_csv(@var{file}, "model", @var{modelname})
##
## Read csv data of Oscilloscpe.
## 
## Model list.
##
## @table @code
## @item "DL1500"
## YOKOGAWA
## @item "TDS3000"
## Tektronics
## @item "DPO4000"
## Tektronics
## @item "auto"
## try model "DPO4000" and next try "TDS3000"
## @end table
##
## Here is a list of an output structure.
##
## @table @code
## @item data
## cell array of matrix
## @end table
##
## @seealso{default_osc_model}
## @end deftypefn

##== History
## 2014-11-04
## * use !ischar instead of isna to support 3.8.2
## 2013-11-08
## * added a check of number of arguments.
## 2013-01-10
## * pkg load io at the beginneing.
## 2010-08-26
## * ignored last line of data in _tek1
## 2009-06-22
## * add "model" property to support multiple makers and models.
## 2007-04-12
## * support octave 2.9.9 
## 2006-??-??
## * first implementaion

function retval = load_osc_csv(filepath, varargin)
  pkg load io;
  if !nargin
    print_usage();
  endif
  
  if length(varargin) < 2
    error("Number of optional arguments is invalid. It must be 2.");
  endif
  opts = get_properties(varargin, {"model", NA});
  if !ischar(opts.model)
    opts.model = default_osc_model();
  endif
  switch opts.model
    case "DL1500"
      retval = _yokogawa1(filepath);
    case "TDS3000"
      retval = _tek1(filepath);
    case "DPO4000"
      retval = _tek2(filepath);
    case "TDS2000"
      retval = _tek3(filepath)
    case "auto"
      try
        retval = _tek2(filepath);
      catch
        retval = _tek1(filepath);
      end_try_catch
    otherwise
      error([opts.model, " is unknow model."]);
  endswitch
  retval.filepath = filepath;
endfunction

function retval = _tek3(filepath) # for TDS2000
  #  not implemented
endfunction

function retval = _tek2(filepath) # for DPO400
  # filepath = "tek00013CH3.csv";
  [fid, msg] = fopen(filepath, "r");
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
  
  data = csvread(filepath, nhead, 0);
  data = data(1:end-1,:);
  retval.data = {};
  retval.samplerate = 1/(data(2,1) - data(1,1));
  t = data(:,1);
  switch (retval.Horizontal_Units)
    case ("S")
      t = t*1e3;
  endswitch
  
  # in somecase, last data is invalid
  if (t(end) == 0) && (t(end) < t(end-1))
    t(end) = [];
    data = data(1:end-1,:);
  endif
  
  for n = 2:ndata
    retval.data{end+1} = [t, data(:,n)];
  endfor
endfunction

function retval = _tek1(filepath)
  # filepath = "tek00013CH3.csv";
  [fid, msg] = fopen(filepath, "r");
  if (fid == -1)
    error(msg);
  endif
  
  ## read header
  nhead = 1;
  aline = deblank(fgetl(fid));
  ndata = 2;
  while (aline != -1)
    cells = csvexplode(aline);
    
    if (!ischar(cells{1}))
      ndata = length(cells);
      break;
    endif

    nhead++;
    if (length(aline) == 1)
      break;
    endif
    aline = deblank(fgetl(fid));

  endwhile
  fclose(fid);
  
  data = csvread(filepath, nhead, 0);
  if (data(end,1) < data(end-1, 1) )
    data(end,:) = []; # remove last row ,
                      # because last row may 0 value due to last empty line
  endif
  retval.data = {};
  for n = 2:ndata;
    retval.data{end+1} = [data(:,1), data(:,n)];
  endfor

  retval.samplerate = 1/(data(2,1) - data(1,1));
endfunction

function retval = _yokogawa1(filepath)
  zipfilename = find_zipfile(filepath);
  
  if isempty(zipfilename)
    [fid, msg] = fopen(filepath, "r");
  else
    fid = popen(sprintf("unzip -p '%s' '%s'" ...
                ,zipfilename, basename(zipfilename, "\.zip")), "r");
    if (fid == -1)
      msg = "Faild to popen for unzip";
    endif
  endif
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
        # amatch = regexp("[^ .]+", astr); #
        # cells{n} = astr(amatch(1):amatch(2));
        [s_pos, e_pos]  = regexp(astr, "[^ .]+", "start", "end");
        cells{n} = astr(s_pos: e_pos);
      endif
      
    endfor
    retval.(cells{1}) = cells(2:end);
    aline = deblank(fgetl(fid));
  endwhile
  #fclose(fid);
  
  #data = csvread(filepath, nhead, 0);
  data = csvread(fid, 0, 0); fclose(fid);
  block_size = retval.BlockSize{1};
  sample_rate = retval.SampleRate{1};
  switch (retval.SampleRate{2})
    case ("MHz")
      sample_rate = sample_rate*1e6;
    case ("kHz")
      sample_rate = sample_rate*1e3;
  endswitch
  trigger_point = retval.TriggerPointNo{1};
  time = (-1*(trigger_point-1)):(block_size - trigger_point);
  msec = time/sample_rate*1e3;
  retval.data = {};
  for n = 1:length(retval.TraceName);
    retval.data{end+1} = [msec(:), data(:,n)];
    #retval.data = {[msec(:), data(:,1)], [msec(:), data(:,2)]};
  endfor
endfunction

function zipfilename = find_zipfile(filename)
  zipfilename = [];
  if !exist(filename, "file")
    zipfilename = [filename, ".zip"];
    if !exist(zipfilename, "file");
      error(["Can't find a file : ", filename]);
    endif
  elseif !isempty(regexp(filename, "\.zip$"))
    zipfilename = filename;
  endif
endfunction