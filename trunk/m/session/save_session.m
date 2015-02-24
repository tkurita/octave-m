## save all variables into the file "session-yyyymmdd.mat"

## $Date$
## $Rev$
##== History
## 2015-02-24
## * reimplement with function.
## 2014-11-25
## * added SESSION_ID support.
## 2014-11-20
## * use session_filename
## * append "-binary" option
## 2013-06-20
## * saved session file is commpresed with zip.
## 2011-03-03
## * First Implementation

function save_session(varargin)
  if length(varargin)
    ssfilename = session_filename(varargin{1});
  elseif evalin("caller", "exist SESSION_ID")
    ssfilename = session_filename(evalin("caller", "SESSION_ID"));
  else
    ssfilename = session_filename();
  endif
  evalin("caller", sprintf("save -z -binary '%s'",ssfilename));
  disp(["success to save session into ", ssfilename]);
endfunction