## usage : trcRec = loadtrc(filepath)
##
## load trc file which saved by the spectrum analyzer
##
## = Parameters
## * filepath -- a path to a .trc file
##
## = Result
## * trcRec -- a structure with following fields
##      .XScale
##      .XStart 
##      .XNum
##      .... infomation in file header
##      .data -- [frequency, y]
##          or
##      .data -- [time, y]

function trcRec = loadtrc(filepath)
  #filepath = "008.trc"
  mat = load(filepath);
  [fid, msg] = fopen(filepath, "r");
  aline = fgetl(fid);
  while (findstr(aline, "#", 0))
    # match = regexp("^# (.+)=(.+)$", aline) #vesion 2.1 用
    #key = aline(match(2,1):match(2,2));
    #val = aline(match(3,1):match(3,2));
    [s_pos, tokens]  = regexp(aline, "^# (.+)=(.+)$", "start", "tokens");
    key = tokens{1}{1};
    val = tokens{1}{2};
    trcRec.(deblank(key)) = deblank(val);
    aline = fgetl(fid);
  endwhile
  fclose(fid);
  #xscale = str2num(trcRec.XScale(1:end-1));
  #xmin = str2num(xmin)*order;
  
  xscale = str_with_unit2num(trcRec.XScale);
  xmin = str_with_unit2num(trcRec.XStart);
  xnum = str2num(trcRec.XNum);
  trcRec.XNum = xnum;
  delx = xscale/(xnum-1);
  xmax = xmin+xscale;
  trcRec = append_fields(trcRec, xmin, xmax);
  xlist = xmin:delx:(xmax);
  size(xlist);
  trcRec.data = [xlist(:), vec(mat(:,1))];
endfunction

function result = str_with_unit2num(instring)
  #printf("instring %s\n", instring);
  if (isalpha(instring(end)))
    num_string= instring(1:end-1);
    switch (instring(end))
      case ("M")        
        order = 1e6;
      case ("k")
        order = 1e3;
    endswitch
  else
    num_string = instring;
    order = 1;
  endif
  result = str2num(num_string)*order;
endfunction