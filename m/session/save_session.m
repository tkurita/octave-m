## -*- texinfo -*-
## @deftypefn {Function File} {} save_session([@var{SESSION_ID}])
## Save all variables into the file "session-[@var{SESSION_ID}-]yyyymmdd.mat"
##
## @strong{Inputs}
## @table @var
## @item SESSION_ID
## A name of a session.
## If the value is not passes as an argument and 
## a variable "SESSION_ID" in the "caller" context will be used.
## @end table
##
## @seealso{load_session, purge_session}
## @end deftypefn

## $Date::                           $
## $Rev$
## $Author$

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
  elseif evalin("caller", "exist('SESSION_ID', 'var')")
    ssfilename = session_filename(evalin("caller", "SESSION_ID"));
  else
    ssfilename = session_filename();
  endif
  evalin("caller", sprintf("save -z -binary '%s'",ssfilename));
  disp(["success to save session into ", ssfilename]);
endfunction