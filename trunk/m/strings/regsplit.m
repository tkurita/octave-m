## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} regsplit(@var{str}, @var{pat})
##
## @end deftypefn

##== History
## 2008-08-07
## * first implementation

function retval = regsplit(str, pat)
  [S, E, TE, M, T, NM] = regexp(str, pat);
  if (length(S) == 0)
    retval = {str};
    return;
  endif

  retval = {};
  if (E(end) == length(str))
    E(end) = [];
  else
    S = [S, length(str)+1];
  endif

  if (S(1) > 1)
    E = [0, E];
  else
    S(1) = [];
  endif
  E = E + 1;
  S = S - 1;
  for n = 1:length(E)
    retval{end+1} = str(E(n):S(n));
  endfor
endfunction

%!test
%! regsplit("ccc", "/")
