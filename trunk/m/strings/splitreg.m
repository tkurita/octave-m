## usage: outList = splitreg(inStr, pattern)

function outList = splitreg(inStr, pattern)
  #  pattern = "\\n";
  #  inStr = "hello\nhey\noh\naaa\n";
  outList = {};
  [S, E, TE, M, T, NM] = regexp(inStr, pattern);
  if (E(end) == length(inStr))
    E = E(1:end-1);
    #S = S(1:end-1);
  else
    S(end+1) = length(inStr)+1;
  endif
  spos = E+1;
  epos = S-1;
  if (S(1) != 1)
    spos = [1, spos];
  else
    epos = epos(2:end);
  endif

  for n = 1:length(spos)
    outList(end+1) = inStr(spos(n):epos(n));
  endfor

  # outList
endfunction


%!test
%! regsplit("/aaa/cccc", "/")