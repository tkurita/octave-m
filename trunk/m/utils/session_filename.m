## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} session_filename(@var{optname})
## make a filename to save session of "session-[@var{optname}]-yyyymmdd.mat"
##
## @end deftypefn

##== History
## 2014-11-20
## * first implementation

function retval = session_filename(optname)
  session_name = "session-";
  if nargin > 0
    session_name = [session_name, optname, "-"];
  endif
  retval = [session_name, strftime("%Y%m%d", localtime(time())), ".mat"];
endfunction

%!test
%! func_name(x)
