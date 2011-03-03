## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} purge_session(@var{arg})
## remove old session files
##
##
## @end deftypefn

##== History
## 2011-03-03
## * first implementation

function retval = purge_session()
  files = readdir("./");
  oldfiles = {};
  olddate = 0;
  lastfile = NA;
  for n = 1:length(files)
    # n = 13
    a_file = files{n};
    [S, E, TE, M, T, NM] = regexp(a_file, "session-(\\d+)\\.mat");
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

%!test
%! purge_session(x)
