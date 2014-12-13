## save all variables into the file "session-yyyymmdd.mat"

##== History
## 2014-11-25
## * added SESSION_ID support.
## 2014-11-20
## * use session_filename
## * append "-binary" option
## 2013-06-20
## * saved session file is commpresed with zip.
## 2011-03-03
## * First Implementation

if exist("SESSION_ID")
  ssfilename = session_filename(SESSION_ID);
else
  ssfilename = session_filename();
endif
save("-z","-binary", ssfilename);
disp(["success to save session into ", ssfilename]);
