## load last session file

##== History
## 2014-11-25
## * added SESSION_ID support.
## 2014-11-17
## * fixed for 3.8.2.
## 2014-08-01
## * if "session_init.m" exists in load paths, the file will be preformed as a script file.
## 2013-10-25
## * A variable session_file is not used. 
##   Because if same name variable is included in the loaded session file, 
##   the file name in the message will be invalid.
## 2011-03-03
## * First Implementaion

1;

function lastssfile = last_session_file(varargin)
  lastssfile = [];
  optname = [];
  if length(varargin)
    optname = [varargin{1}, "-"];
  endif
  files = readdir("./");
  lastssfile = [];
  lastdate = 0;
  namae_pattern =  ["session-", optname, "(\\d+)\\.mat"];
  for n = 1:length(files)
    # n = 13
    a_file = files{n};
    [S, E, TE, M, T, NM] = regexp(a_file,namae_pattern);
    if S
      d = str2num(T{1}{1});
      if d > lastdate
        lastdate = d;
        lastssfile = a_file;
      endif
    endif
  endfor

  if isempty(lastssfile)
    error(["No session file in ", pwd]);
    return false;
  endif
  return true;
endfunction

if exist("SESSION_ID", "var")
  ssfilename = last_session_file(SESSION_ID);
  init_file = ["session-", SESSION_ID, "-init.m"];
else
  ssfilename = last_session_file();
  init_file = "session-init.m";
endif

if load(ssfilename);
  if exist(init_file, "file")
    session_init
  endif
  disp(["Success to load ", ssfilename]);
endif