## save all variables into the file "session-yyyymmdd.mat"

##== History
## 2013-06-20
## * saved session file is commpresed with zip.
## 2011-03-03
## * First Implementation

ssfilename = ["session-", strftime("%Y%m%d", localtime(time())), ".mat"];
save("-z", ssfilename);

disp(["success to save session into ", ssfilename]);
