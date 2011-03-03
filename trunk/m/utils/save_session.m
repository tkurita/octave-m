## save all variables into the file "session-yyyymmdd.mat"

##== History
## 2011-03-03
## * First Implementation

ssfilename = ["session-", strftime("%Y%m%d", localtime(time())), ".mat"];
save(ssfilename);

disp(["success to save session into ", ssfilename]);
