## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} session_basename(@var{optname})
## make a base name for a session file. "session-[@var{optname}]-"
##
## @end deftypefn

##== History
## 2014-02-16
## * first implementation

function retval = session_basename(optname)
  retval = "session-";
  if nargin > 0
    retval = [retval, optname, "-"];
  endif
endfunction

%!test
%! func_name(x)
