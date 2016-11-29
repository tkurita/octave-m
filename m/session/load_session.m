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
## If "session-init.m" exists in the current directory,
## the file will be loaded just before the session file.
## The "session-init.m" can be used to load packages required for the session.
##
## @seealso{save_session, purge_session}
## @end deftypefn


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
