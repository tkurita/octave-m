## -*- texinfo -*-
## @deftypefn {Function File} {@var{filename} =} last_session_file()
## @deftypefnx {Function File} {@var{filename} =} last_session_file(@var{session_id})
## Find last session file from the current directory.
## 
## @strong{Inputs}
## @table @var
## @item session_id
## Optional. 
## @end table
##
## @seealso{save_session, load_session, purge_session}
## @end deftypefn

## $Date::                           $
## $Rev$
## $Auther$

##== History
## 2015-02-25
## * Become independent of load_session

function lastssfile = last_session_file(varargin)
  lastssfile = [];
  optname = [];
  if length(varargin)
    optname = [varargin{1}, "-"];
  endif
  files = readdir("./");
  lastssfile = [];
  lastdate = 0;
  namae_pattern =  ["session-", optname, "(\\d+)\\.mat"];
  for n = 1:length(files)
    # n = 13
    a_file = files{n};
    [S, E, TE, M, T, NM] = regexp(a_file,namae_pattern);
    if S
      d = str2num(T{1}{1});
      if d > lastdate
        lastdate = d;
        lastssfile = a_file;
      endif
    endif
  endfor

  if isempty(lastssfile)
    error(["No session file in ", pwd]);
    return;
  endif
endfunction

%!test
%! last_session_file
