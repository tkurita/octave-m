## save all variables into the file "session-yyyymmdd.mat"

##== History
## 2014-11-20
## * use session_filename
## * append "-binary" option
## 2013-06-20
## * saved session file is commpresed with zip.
## 2011-03-03
## * First Implementation

save("-z","-binary", session_filename());

disp(["success to save session into ", ssfilename]);
