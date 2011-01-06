## useage : plotterm(termName)
##
##
## 一度、プロットターミナルを閉じる必要がある

function plotterm(termName)
  #eval (sprintf ("__gnuplot_set__ terminal %s;",termName));
  putenv("GNUTERM", termName);
endfunction
