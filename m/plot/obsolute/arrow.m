## useage : arrow(axisname)
## 未実装 vline で縦線は引ける
## arguments
## axisname : x|y|x2|y2
## to do linetype と line width を設定できるようにする。
function arrow(axisname)

  eval (sprintf ("__gnuplot_set__ %szeroaxis;",axisname));
#   if (nargin == 0)
# 	__gnuplot_set__ autoscale;
#   else
# 	eval (sprintf ("__gnuplot_set__ &szeroaxis [%g:%g];",axisname, xmax));
#   endif

  if (automatic_replot)
    replot ();
  endif

endfunction