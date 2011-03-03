## load last session file

##== History
## 2011-03-03
## * First Implementaion

1;

function lastssfile = last_session_file()
  files = readdir("./");
  lastssfile = NA;
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

  if isna(lastssfile)
    error(["No session file in ", pwd]);
  endif
endfunction


session_file = last_session_file();
load(session_file);
disp(["Success to load ", session_file]);
