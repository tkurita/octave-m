## load last session file

##== History
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
  persistent lastssfile = [];
  if length(varargin)
    return
  else
    lastssfile = [];  
  endif
  files = readdir("./");
  lastssfile = [];
  lastdate = 0;
  for n = 1:length(files)
    # n = 13
    a_file = files{n};
    [S, E, TE, M, T, NM] = regexp(a_file, "session-(\\d+)\\.mat");
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
  endif
endfunction

load(last_session_file());
if exist("session_init.m", "file")
  session_init
endif
disp(["Success to load ", last_session_file("filename")]);
