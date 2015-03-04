## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} purge_session(@var{arg})
## remove old session files
##
## @end deftypefn

##== History
## 2015-02-16
## * added support SESSION_ID
## 2011-03-03
## * first implementation

if exist("SESSION_ID")
  a_basename = session_basename(SESSION_ID);
else
  a_basename = session_basename();
endif

function retval = __purge_session__(a_basename)
  files = readdir("./");
  oldfiles = {};
  olddate = 0;
  lastfile = NA;
  for n = 1:length(files)
    # n = 13
    a_file = files{n};
    [S, E, TE, M, T, NM] = regexp(a_file, [a_basename,"(\\d+)\\.mat"]);
    if S
      d = str2num(T{1}{1});
      if olddate > 0
        if d < olddate
          oldfiles{end+1} = a_file;
        else
          oldfiles{end+1} = lastfile;
          lastfile = a_file;
          olddate = d;
        endif
      else
        olddate = d;
        lastfile = a_file;
      end
    endif
  endfor
  
  for n = 1:length(oldfiles)
    unlink(oldfiles{n});
    disp(["purged ",oldfiles{n}]);
  endfor

endfunction

__purge_session__(a_basename);

%!test
%! purge_session(x)
