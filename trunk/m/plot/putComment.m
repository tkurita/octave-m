## useage : putComment(commentText)
##
## 図の左上にテキストを表示する。
## 複数行のテキストを受け入れ可能

function putComment(commentText)
  nLine = size(commentText)(1);
  if (nLine > 1)
    originalText = commentText;
    commentText = "";
    for i = 1:nLine
      commentText = [commentText, originalText(i,:),"\\n"];
    endfor
  endif
  
  #commentText = strrep(commentText, "\n", "\\\\n");
  #eval (sprintf ("__gnuplot_set__ label \"%s\" at graph 0.05,0.95;",commentText));
  text(0.05, 0.95, commentText, "Units","normalized");
  
  if (automatic_replot)
    replot ();
  endif
endfunction