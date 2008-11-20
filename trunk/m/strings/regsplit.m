## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} regsplit(@var{str}, @var{pat})
##
## @end deftypefn

##== History
## 2008-08-13
## * if the sepalated is located at begging or end, the resutl has an empty string at begging or end.
## 
## 2008-08-07
## * first implementation

function retval = regsplit(str, pat)
  [S, E, TE, M, T, NM] = regexp(str, pat);
  if (length(S) == 0)
    retval = {str};
    return;
  endif

  retval = {};
  empty_ended = false;
  if (E(end) == length(str))
    E(end) = [];
    empty_ended = true;
  else
    S = [S, length(str)+1];
  endif

  if (S(1) > 1)
    E = [0, E];
  else
    S(1) = [];
    retval = {""};
  endif
  
  E = E + 1;
  S = S - 1;
  for n = 1:length(E)
    retval{end+1} = str(E(n):S(n));
  endfor
  
  if (empty_ended)
    retval{end+1} = "";
  endif
endfunction

%!test
%! regsplit("ccc", "/")
