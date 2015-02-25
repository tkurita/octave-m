## -*- texinfo -*-
## @deftypefn {Function File} {} load_session()
## @deftypefnx {Function File} {} load_session(@var{session_id})
## Load last session file
##
## @strong{Inputs}
## @table @var
## @item session_id
## Optional. An optional name to give an unique name to a session file.
## @end table
## 
## @seealso{save_session, purge_session}
## @end deftypefn

## $Date::                           $
## $Rev$
## $Auther$

##== History
## 2015-02-25
## * reimplement as a function.
## 2014-11-25
## * added SESSION_ID support.
## 2014-11-17
## * fixed for 3.8.2.
## 2014-08-01
## * if "session_init.m" exists in load paths, 
##   the file will be preformed as a script file.
## 2013-10-25
## * A variable session_file is not used. 
##   Because if same name variable is included in the loaded session file, 
##   the file name in the message will be invalid.
## 2011-03-03
## * First Implementaion

function load_session(varargin)
  ssid = [];
  if length(varargin)
    ssid = varargin{1};
  elseif evalin("caller", "exist SESSION_ID var")
    ssid = evalin("caller", "SESSION_ID");
  endif

  if isempty(ssid)
    ssfilename = last_session_file();
    init_file = "session-init.m";
  else
    ssfilename = last_session_file(ssid);
    init_file = ["session-", ssid, "-init.m"];
  endif
  
  try
    evalin("caller", sprintf("load '%s'", ssfilename))
    disp(["Success to load ", ssfilename]);
  catch
    disp(["Failed to load ", ssfilename]);
    return;
  end_try_catch
  
  if exist(init_file, "file")
    try
      source(init_file);
      disp(["Success to evaluate ", init_file]);
    catch
      disp(["Failed to evaluate ", init_file]);
    end_try_catch
  endif
endfunction
